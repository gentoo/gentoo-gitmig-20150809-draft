# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/entrance/entrance-0.0.2.20030220.ebuild,v 1.1 2003/03/02 08:58:43 vapier Exp $

inherit eutils

DESCRIPTION="next generation of Elogin, a login/display manager for X"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2
	mirror://gentoo/extraicons-1.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/extraicons-1.tar.bz2"

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
	>=x11-libs/ecore-0.0.2.2003*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-autofiles.patch
	epatch ${FILESDIR}/gentoo-sessions.patch
}

pkg_setup() {
	# the stupid gettextize script prevents non-interactive mode, so we hax it
	cp `which gettextize` ${T} || die "could not copy gettextize"
	cp ${T}/gettextize ${T}/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${T}/gettextize.old > ${T}/gettextize
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	econf --with-pam-prefix=/etc/pam.d/ || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	insinto /usr/share/entrance/data/images/sessions
	doins ${WORKDIR}/extraicons/*
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	cd /usr/share/entrance/data/config
	./build_config.sh || die
}
