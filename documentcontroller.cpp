#include "documentcontroller.h"

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
