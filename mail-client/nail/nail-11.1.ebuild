# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/nail/nail-11.1.ebuild,v 1.4 2004/12/08 03:10:44 agriffis Exp $

inherit eutils
DESCRIPTION="Nail is a mail user agent derived from Berkeley Mail 8.1 and contains builtin support for MIME messages."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://nail.sourceforge.net/"
PROVIDE="virtual/mailx"
DEPEND="virtual/libc
	!virtual/mailx"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc ~ppc ~amd64 ~alpha ~ia64"
IUSE=""

src_compile() {
	# ./configure no longer required
	emake PREFIX=/usr MAILSPOOL='~/.maildir' || die "emake failed"
}

src_install () {
	#add smtp flag to nail.rc so that it uses smtp by default (making it
	#essentially mailer independent
	echo -e "\n#use smtp on the local system by default.  Change" >> nail.rc
	echo -e "#\"localhost\" to your smtp server if you use a remote" >> nail.rc
	echo -e "#smtp server.  (Delete this line to use sendmail instead)" >> nail.rc
	echo -e "set smtp=localhost" >> nail.rc

	make DESTDIR=${D} UCBINSTALL=/bin/install PREFIX=/usr install || die "install failed"
	dodoc AUTHORS COPYING I18N INSTALL README
	dodir /bin
	dosym /usr/bin/nail /bin/mail
	dosym /usr/bin/nail /usr/bin/mail
	dosym /usr/bin/nail /usr/bin/Mail
}

pkg_postinst () {
	echo
	einfo "NOTE: The nail mailer does _not_ support maildir format."
	einfo "      It is best to use nail only for outgoing mail, and"
	einfo "      really only use it for scripts that require it."
	echo
	einfo "NOTE: This build has ~/.maildir compiled in as the"
	einfo "      mail spool directory (for incoming mail)."
	einfo "      Nail will work for sending outgoing mail even if"
	einfo "      the mail spool directory does not exist."
	echo
	einfo "NOTE: When used to send mail via a remote smtp server"
	einfo "      nail does not require a local mail transfer agent."
	einfo "      ISP smtp servers tend to have names like"
	einfo "        mail.ispname.com"
	einfo "      or"
	einfo "        smtp.ispname.com."
	einfo "      If you do not wish to use a remote smtp server,"
	einfo "      then you WILL have to install a mta such as sendmail,"
	einfo "      postfix, exim, etcetera."
	echo
}
