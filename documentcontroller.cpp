#include "documentcontroller.h"
#include <QQmlFile>
#include <QMimeType>
#include <QMimeDatabase>

DocumentController::DocumentController(QObject *parent) : QObject(parent)
{

}

QQuickTextDocument *DocumentController::notepadDoc() const {
    return m_notepadDoc;
}

void DocumentController::setNotepadDoc(QQuickTextDocument *doc) {
    m_notepadDoc = doc;
    emit notepadDocChanged();
}

QTextDocument *DocumentController::getQtextDocument() {
    if (m_notepadDoc == nullptr) {
        m_qtextDocument = nullptr;
    } else {
        m_qtextDocument = m_notepadDoc->textDocument();
    }
    return m_qtextDocument;
}

void DocumentController::openFile(const QUrl &fileUrl) {
    if (fileUrl.isEmpty())
        return;
    const QString filename = QQmlFile::urlToLocalFileOrQrc(QUrl(fileUrl));

    if (QFile::exists(filename)) {
        //QMimeType mimeType = QMimeDatabase().mimeTypeForFile(filename);

        QFile fileObj(filename);

        if (fileObj.open(QFile::ReadOnly)) {
            QByteArray content = fileObj.readAll();
            m_qtextDocument = m_notepadDoc->textDocument();

            if(m_qtextDocument) {
                emit fileContentLoaded(QString::fromUtf8(content), Qt::MarkdownText);
                m_qtextDocument->setModified(false);
            }
        }
    }
    m_currentFileUrl = fileUrl;
}
