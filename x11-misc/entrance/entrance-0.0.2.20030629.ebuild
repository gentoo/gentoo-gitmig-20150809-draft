# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/entrance/entrance-0.0.2.20030629.ebuild,v 1.1 2003/06/29 19:17:13 vapier Exp $

inherit enlightenment eutils

DESCRIPTION="next generation of Elogin, a login/display manager for X"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="${SRC_URI}
	mirror://gentoo/extraicons-1.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/extraicons-1.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"

DEPEND="${DEPEND}
	virtual/x11
	sys-libs/pam
	>=dev-db/edb-1.0.3.2003*
	>=media-libs/ebg-1.0.0.2003*
	>=x11-libs/evas-1.0.0.2003*
	>=x11-libs/ecore-0.0.2.2003*"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-sessions.patch
	gettext_modify
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
