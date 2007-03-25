# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.14.ebuild,v 1.8 2007/03/25 21:05:58 armin76 Exp $

DESCRIPTION="Scanner Access Now Easy"
HOMEPAGE="http://www.sane-project.org"
SRC_URI="ftp://ftp.sane-project.org/pub/sane/${P}/${P}.tar.gz
	ftp://ftp.sane-project.org/pub/sane/old-versions/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE="gimp"

DEPEND="media-gfx/sane-backends
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
	local gimpplugindir
	local gimptool
	einstall datadir=${D}/usr/share/misc || die
	if use gimp; then
		for gimptool in gimptool gimptool-2.0 gimptool-1.2; do
			if [ -x /usr/bin/${gimptool} ]; then
				einfo "Setting plugin link for GIMP version	$(/usr/bin/${gimptool} --version)"
				gimpplugindir=$(/usr/bin/${gimptool} --gimpplugindir)/plug-ins
				break
			fi
		done
		if [ "/plug-ins" != "${gimpplugindir}" ]; then
			 dodir ${gimpplugindir}
			dosym /usr/bin/xscanimage ${gimpplugindir}/xscanimage
		else
			ewarn "No idea where to find the gimp plugin directory"
		fi
	fi
	dodoc AUTHORS Changelog NEWS PROBLEMS README
}
