#ifndef DOCUMENTCONTROLLER_H
#define DOCUMENTCONTROLLER_H

#include <QObject>
#include <QQuickTextDocument>
#include <QTextDocument>

class DocumentController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQuickTextDocument *notepadDoc READ notepadDoc WRITE setNotepadDoc NOTIFY notepadDocChanged)
public:
    explicit DocumentController(QObject *parent = nullptr);

    QQuickTextDocument *notepadDoc() const;
    void setNotepadDoc(QQuickTextDocument *doc);
signals:
    void notepadDocChanged();
private:
    QQuickTextDocument *m_notepadDoc;
};

#endif // DOCUMENTCONTROLLER_H
