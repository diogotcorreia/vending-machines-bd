#! /usr/bin/env sh

GROUP=008
FOLDER_NAME=entrega-03-$GROUP

mkdir /tmp/$FOLDER_NAME
cp -r ./web /tmp/$FOLDER_NAME/
cp -r ./reports/report3.pdf /tmp/$FOLDER_NAME/$GROUP-relatorio.pdf
cp -r ./scripts/*.sql /tmp/$FOLDER_NAME/
cp -r ./scripts/*.py /tmp/$FOLDER_NAME/

pushd /tmp
zip -r $FOLDER_NAME.zip $FOLDER_NAME
popd

mv /tmp/$FOLDER_NAME.zip .
rm -r /tmp/$FOLDER_NAME
