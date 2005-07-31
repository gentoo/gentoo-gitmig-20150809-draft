# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/nail/nail-11.25.ebuild,v 1.1 2005/07/31 20:12:21 ferdy Exp $

inherit eutils
DESCRIPTION="Nail is a mail user agent derived from Berkeley Mail 8.1 and contains builtin support for MIME messages."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://nail.sourceforge.net/"
PROVIDE="virtual/mailx"
DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )
	!virtual/mailx"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~alpha ~ia64 ~hppa"
IUSE="ssl"

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
	dosym /usr/bin/nail /usr/bin/mailx
	dosym /usr/bin/nail /usr/bin/mail
	dosym /usr/bin/nail /usr/bin/Mail
}
