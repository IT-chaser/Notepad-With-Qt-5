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

    void fileContentLoaded(const QString &content, int format);

public slots:
    void openFile(const QUrl &fileUrl);

private:
    QTextDocument *getQtextDocument();

    QUrl m_currentFileUrl;
    QTextDocument *m_qtextDocument;
    QQuickTextDocument *m_notepadDoc;
};

#endif // DOCUMENTCONTROLLER_H
