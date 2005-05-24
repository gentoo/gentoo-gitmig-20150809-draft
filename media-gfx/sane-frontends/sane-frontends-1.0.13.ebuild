# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.13.ebuild,v 1.7 2005/05/24 01:20:01 vapier Exp $

DESCRIPTION="Scanner Access Now Easy"
HOMEPAGE="http://www.sane-project.org"
SRC_URI="ftp://ftp.mostang.com/pub/sane/${P}/${P}.tar.gz
	ftp://ftp.mostang.com/pub/sane/old-versions/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE="gimp"

DEPEND=">=media-gfx/sane-backends-${PV}
	gimp? ( media-gfx/gimp )"

src_compile() {
	local myconf=""
	use gimp || myconf="--disable-gimp"
	use gimp && ! has_version ">=media-gfx/gimp-2" && myconf="--enable-gimp12"
	econf \
		--datadir=/usr/share/misc \
		${myconf} || die
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
	dodoc AUTHORS Changelog NEWS PROBLEMS README TODO
}
