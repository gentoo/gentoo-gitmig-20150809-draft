# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/e/e-0.17.20030629_pre0.ebuild,v 1.1 2003/06/29 19:20:40 vapier Exp $

inherit enlightenment

DESCRIPTION="window manager and desktop shell"
HOMEPAGE="http://www.enlightenment.org/pages/enlightenment.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"

DEPEND="${DEPEND}
	virtual/x11
	>=media-libs/imlib2-1.0.6.2003*
	>=x11-libs/evas-1.0.0.2003*
	>=dev-db/edb-1.0.3.2003*
	>=media-libs/ebits-1.0.1.2003*
	>=x11-libs/ecore-0.0.2.2003*
	>=sys-apps/efsd-0.0.1.2003*
	>=media-libs/ebg-1.0.0.2003*
	>=media-libs/imlib2_loaders-1.0.4.2003*
	>=media-libs/freetype-2.1.3*
	perl? ( dev-lang/perl )"

S=${WORKDIR}/${PN}

src_compile() {
	env WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	econf --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog NEWS README
	dohtml -r doc

	# fix name clash with 0.16.x
	cd ${D}/usr/bin
	mv enlightenment{,-0.17}

	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/e17
}
