# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/elogin/elogin-0.0.2.20030220.ebuild,v 1.1 2003/03/02 08:59:56 vapier Exp $

inherit eutils

DESCRIPTION="Enlightenment Login Thingie, a login/display manager for X"
HOMEPAGE="http://www.enlightenment.org/pages/elogin.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	virtual/glibc
	sys-devel/gcc
	sys-libs/pam
	>=dev-db/edb-1.0.3.2003*
	>=media-libs/ebg-1.0.0.2003*
	>=x11-libs/evas-1.0.0.2003*
	>=x11-libs/ecore-0.0.2.2003*
	>=media-libs/estyle-0.0.1.2003*
	>=dev-libs/ewd-0.0.1.2003*"

S=${WORKDIR}/${PN}

pkg_setup() {
	# the stupid gettextize script prevents non-interactive mode, so we hax it
	cp `which gettextize` ${T} || die "could not copy gettextize"
	cp ${T}/gettextize ${T}/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${T}/gettextize.old > ${T}/gettextize
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-paths.patch
	epatch ${FILESDIR}/${P}-autofiles.patch
	epatch ${FILESDIR}/gentoo-sessions.patch
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	econf --with-pam-prefix=/etc/pam.d/ || die

	emake || die

	cd data/config
	./build_config.sh || die "could not create default session list"
}

src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	rm -rf ${D}/usr/share/${PN}/data/{init,pam}.d
	dodoc AUTHORS README TODO
}
