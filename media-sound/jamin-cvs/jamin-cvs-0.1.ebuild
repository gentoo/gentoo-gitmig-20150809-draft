# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jamin-cvs/jamin-cvs-0.1.ebuild,v 1.3 2003/09/11 01:21:31 msterret Exp $

ECVS_SERVER="cvs.jamin.sourceforge.net:/cvsroot/jamin"
ECVS_MODULE="jam"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/jamin/"
inherit cvs

DESCRIPTION="A mastering application for jack"
HOMEPAGE="http://jamin.sourceforge.net/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-libs/glib
	>=media-libs/libsndfile-1.0.0
	>=media-plugins/swh-plugins-0.4.2
	>=media-sound/jack-cvs-0.7.0
	>=sys-devel/autoconf-2.5"

#S=${WORKDIR}/${P}
S=${WORKDIR}/jam

src_compile() {
	export WANT_AUTOCONF_2_5=1
	sh autogen.sh
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"

	cd pixmaps
	dodir /usr/share/jamin/pixmaps
	cp * ${D}/usr/share/jamin/pixmaps
}

pkg_postinst() {
	einfo "edit your .jamrc"
	einfo "pixmaps are in /usr/share/jamin/pixmaps"
}
