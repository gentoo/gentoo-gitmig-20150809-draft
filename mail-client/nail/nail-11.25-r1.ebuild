# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/nail/nail-11.25-r1.ebuild,v 1.1 2005/08/10 18:16:46 ferdy Exp $

inherit eutils
DESCRIPTION="Nail is an enhanced mailx-compatible mail client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://nail.sourceforge.net/"
PROVIDE="virtual/mailx"
DEPEND="ssl? ( dev-libs/openssl )
	!virtual/mailx"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~alpha ~ia64 ~hppa"
IUSE="ssl net"

src_compile() {
	# Build config.h and LIBS, neccesary to tweak the config
	make config.h

	# Hack to remove openssl
	if ! use ssl ; then
		sed -i -e 's~#define USE_\(OPEN\)\?SSL~#undef USE_\1SSL~' config.h
		sed -i -e 's~-lssl~~' -e 's~-lcrypto~~' LIBS
	fi

	# And now to remove the IMAP/POP/SMTP stuff
	use net || \
		sed -i -e 's~#define HAVE_SOCKETS~#undef HAVE_SOCKETS~' config.h

	# Now really build it
	emake PREFIX=/usr MAILSPOOL='~/.maildir' || die "emake failed"
}

src_install () {
	# Use /usr/lib/sendmail by default and provide an example
	use net && cat <<- EOSMTP >> nail.rc

		# Use the local sendmail (/usr/lib/sendmail) binary by default.
		# (Uncomment the following line to use a SMTP server)
		#set smtp=localhost
	EOSMTP

	make DESTDIR=${D} UCBINSTALL=/bin/install PREFIX=/usr install || die "install failed"
	dodoc AUTHORS COPYING INSTALL README
	dodir /bin
	dosym /usr/bin/nail /bin/mail
	dosym /usr/bin/nail /usr/bin/mailx
	dosym /usr/bin/nail /usr/bin/mail
	dosym /usr/bin/nail /usr/bin/Mail
}
