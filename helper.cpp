#include "helper.h"

#include <QRandomGenerator>
#include <QDebug>

Helper::Helper(QObject *parent) : QObject(parent)
{

}

int Helper::randomXForRoad()
{
    int x = QRandomGenerator::global()->bounded(240, 471);
    return x;
}

int Helper::randomXForOffroad()
{
    int x;
    int side = QRandomGenerator::global()->bounded(1, 3);

    if (side == 1)
        x = QRandomGenerator::global()->bounded(-10, 181);

    if (side == 2)
        x = QRandomGenerator::global()->bounded(500, 681);

    return x;
}

int Helper::randomCarImage()
{
    int imageNumber = QRandomGenerator::global()->bounded(1, 7);

    return imageNumber;
}

int Helper::randomObstacleImage()
{
    int imageNumber = QRandomGenerator::global()->bounded(1, 5);

    return imageNumber;
}

int Helper::randomTreeImage()
{
    int imageNumber = QRandomGenerator::global()->bounded(1, 4);

    return imageNumber;
}
