#ifndef MEDIATOR_H
#define MEDIATOR_H

#include <QObject>
#include <QProcess>
#include <QFile>
#include <QDebug>

class Mediator : public QObject
{
    Q_OBJECT

//    Q_PROPERTY(QByteArray filePath READ filePath WRITE setFilePath)

public:
    explicit Mediator(QObject *parent = nullptr);

    Q_INVOKABLE QByteArray filePath() const;
    Q_INVOKABLE QByteArray modelSummary();
    Q_INVOKABLE QByteArray eval_Model();
    Q_INVOKABLE QByteArray predictionAt(int pos) const;
    Q_INVOKABLE void setFilePath(const QByteArray &path);
    Q_INVOKABLE void startTrainning();
    Q_INVOKABLE void predict();
    Q_INVOKABLE void createDataPlot();
    Q_INVOKABLE bool saveDataPathToFile();
    Q_INVOKABLE int count() const;
    Q_INVOKABLE void loadPredictions();
    void log(const QString &filename);
    void runRScript(const QString &script);    

signals:
    void trainningFinished();
    void plotingFinished();
    void predictFinished();

public slots:

private:
    QByteArray m_dataFilePath;
    QByteArray m_fileLog;
    QList<QByteArray> m_prediction;
};

#endif // DATAMEDIATOR_H
