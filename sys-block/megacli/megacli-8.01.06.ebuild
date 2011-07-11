# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/megacli/megacli-8.01.06.ebuild,v 1.1 2011/07/11 18:42:13 idl0r Exp $

EAPI="3"

inherit rpm

DESCRIPTION="LSI Logic MegaRAID Command Line Interface management tool"
HOMEPAGE="http://www.lsi.com/"
SRC_URI="http://www.lsi.com/downloads/Public/MegaRAID%20Common%20Files/${PV}_Linux_MegaCLI.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	app-admin/chrpath"
RDEPEND="sys-fs/sysfsutils"

S="${WORKDIR}"

RESTRICT="mirror"

QA_PRESTRIPPED="/opt/bin/megacli"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./MegaCliLin.zip || die "failed to unpack inner ZIP"
	rpm_unpack ./MegaCli-${PV}-1.i386.rpm || die "failed to unpack RPM"
}

src_install() {
	exeinto /opt/bin
	case ${ARCH} in
		amd64) MegaCli=MegaCli64;;
		x86) MegaCli=MegaCli;;
		*) die "invalid ARCH";;
	esac
	newexe opt/MegaRAID/MegaCli/${MegaCli} megacli || die
	dosym /opt/bin/megacli /opt/bin/MegaCli
	dodoc ${PV}_Linux_MegaCLI.txt

	# Get a rid of DT_RPATH
	chrpath -d "${D}/opt/bin/megacli"
}

pkg_postinst() {
	einfo
	einfo "See /usr/share/doc/${PF}/${PV}_Linux_MegaCli.txt for a list of supported controllers"
	einfo "(contains LSI model names only, not those sold by 3rd parties"
	einfo "under custom names like Dell PERC etc)."
	einfo
	einfo "As there's no dedicated manual, you might want to have"
	einfo "a look at the following cheat sheet (originally written"
	einfo "for Dell PowerEdge Expandable RAID Controllers):"
	einfo "http://tools.rapidsoft.de/perc/perc-cheat-sheet.html"
	einfo
	einfo "For more information about working with Dell PERCs see:"
	einfo "http://tools.rapidsoft.de/perc/"
	einfo
}