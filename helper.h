#ifndef HELPER_H
#define HELPER_H

#include <QObject>

class Helper : public QObject
{
    Q_OBJECT
public:
    explicit Helper(QObject *parent = nullptr);

signals:

public slots:
    int randomXForRoad();

    int randomXForOffroad();

    int randomCarImage();

    int randomObstacleImage();

    int randomTreeImage();
};

#endif // HELPER_H
