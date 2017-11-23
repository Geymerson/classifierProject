/**
    The Mediator class acts as a bridge that
    links the R function calls and the
    C++/Qml application

    @author: Geymerson Ramos
    email: geymerson@ic.ufal.br
    Universidade Federal de Alagoas
**/

#include "./header/mediator.h"

Mediator::Mediator(QObject *parent) : QObject(parent) {

}

//Set the path of the file which contains the user dataset
void Mediator::setFilePath(const QByteArray &path) {
    m_dataFilePath = path;
    saveDataPathToFile();
}

//Return a path to a data file previously
//informed by a user
QByteArray Mediator::filePath() const {
    return m_dataFilePath;
}

//Save the informed file path to into a
//accessible file
bool Mediator::saveDataPathToFile() {    
    QFile file("../classifierProject/resources/dataFilePath.txt");
    if(!file.open( QIODevice::WriteOnly | QIODevice::Text))
        return false;
    m_dataFilePath.append('\n');
    file.write(m_dataFilePath);
    file.close();
    return true;
}

//Return the number of prediction to be made
int Mediator::count() const {
    return m_prediction.length();
}

//Execute the network trainning
void Mediator::startTrainning() {
    runRScript("trainningScript.r");
    emit trainningFinished();
}

//Predict some entries based on the
//trainning model
void Mediator::predict() {
    runRScript("predictionScript.r");
    emit predictFinished();
}

//Plot the dataset in use to create
//the prediction model
void Mediator::createDataPlot() {
    runRScript("plotDataScript.r");
    emit plotingFinished();
}

//Get the resume of the model information
QByteArray Mediator::modelSummary() {
    log("../classifierProject/rlogs/modelSummary.log");
    return m_fileLog;
}

//Get the model evaluation
QByteArray Mediator::eval_Model() {
    log("../classifierProject/rlogs/eval_model.log");
    return m_fileLog;
}

//Check the result of the prediction at position 'pos'
QByteArray Mediator::predictionAt(int pos) const {
    return m_prediction.at(pos);
}

//Load the data prediction saved in a local file
void Mediator::loadPredictions() {
    m_prediction.clear();
    QFile file("../classifierProject/rlogs/prediction.log");
    if(!file.open( QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "The file could not be opened.";
        return;
    }
    while (!file.atEnd() && m_prediction.length() < 100) {
        QByteArray temp = file.readLine();
        temp.remove(0, 5);
        temp.remove(temp.length() - 2, temp.length());
        m_prediction.append(temp);
    }
}

//Method for saving R function logs for
//later visialization
void Mediator::log(const QString &filename) {
    m_fileLog.clear();
    QFile file(filename);
    if(!file.open( QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "The file could not be opened.";
        return;
    }
    while (!file.atEnd()) {
        m_fileLog.append(file.readLine());
    }
}

//Method for executing the R is a writer
void Mediator::runRScript(const QString &script) {
    if(!saveDataPathToFile()) {
        qDebug() << "The data path could not be saved to file";
        return;
    }
    QProcess process;
    QString command("R --file=/home/geymerson/Documents/ecom_089_2017_1/classifierProject/rscript/");
    command.append(script);
    process.start(command);
    process.waitForFinished();
}

