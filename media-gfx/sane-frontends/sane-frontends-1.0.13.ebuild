# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.13.ebuild,v 1.6 2005/04/08 19:43:47 cryos Exp $

DESCRIPTION="Scanner Access Now Easy"
HOMEPAGE="http://www.sane-project.org"
SRC_URI="ftp://ftp.mostang.com/pub/sane/${P}/${P}.tar.gz
		ftp://ftp.mostang.com/pub/sane/old-versions/${P}/${P}.tar.gz"

DEPEND=">=media-gfx/sane-backends-${PV}
	gimp? ( media-gfx/gimp )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc ppc64"
IUSE="gimp"

src_compile() {
	local myconf=""
	use gimp || myconf="--disable-gimp"
	use gimp && if ! has_version ">=media-gfx/gimp-2"; then \
					myconf="--enable-gimp12"; fi
	econf \
		--datadir=/usr/share/misc ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	einstall datadir=${D}/usr/share/misc || die
	if use gimp; then
		local gimpshortversion=$(best_version media-gfx/gimp \
						| cut -f 1,2 -d "." | cut -f 3 -d "-")
		einfo "Setting plugin link for GIMP version	${gimpshortversion}.x"

		gimpplugindir=$(/usr/bin/gimptool-${gimpshortversion} \
						--gimpplugindir)/plug-ins

		dodir ${gimpplugindir}
		dosym /usr/bin/xscanimage ${gimpplugindir}/xscanimage
	fi
	dodoc AUTHORS COPYING Changelog NEWS PROBLEMS README TODO
}
