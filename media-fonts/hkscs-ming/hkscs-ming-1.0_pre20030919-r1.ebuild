# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/hkscs-ming/hkscs-ming-1.0_pre20030919-r1.ebuild,v 1.11 2007/07/02 15:04:42 peper Exp $

inherit rpm font

RESTRICT="mirror strip binchecks"

RPM_V=1.0

DESCRIPTION="Hong Kong SAR Government Official Reference Chinese Font that implements ISO10646 and HKSCS-2001"
HOMEPAGE="http://www.info.gov.hk/digital21/eng/hkscs/hkscs_iso.html"
SRC_URI="http://www.info.gov.hk/digital21/chi/hkscs/download/linux_redhat/setup.bin"

LICENSE="HKSCS"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ia64 ppc s390 sh x86 ~x86-fbsd"
IUSE=""

DEPEND=""

S=${WORKDIR}
FONT_S="${S}/usr/share/inputmethod"
FONT_SUFFIX="ttf"

src_unpack() {
	# complicated and convoluted unpack procedure
	local linenumber=237
	cd "${S}"; tail -n +${linenumber} "${DISTDIR}/${A}" | tar zxvf - || die "unpack failed"

	# then we rpm_unpack the fonts package
	rpm_unpack "${S}/package_rh/imfont-${RPM_V}-0.i386.rpm"
}

src_compile() { :; }

pkg_postinst() {
	elog "The font name installed is 'Ming(for ISO10646)'. To add make it"
	elog "the default Chinese font, you should add entries to your"
	elog "/etc/fonts/local.conf similar to:"
	elog
	elog "<alias>"
	elog "	   <family>Luxi Sans</family>"
	elog "	   <family>Bitstream Vera Sans</family>"
	elog "	   <family>Ming(for ISO10646)</family>"
	elog "	   <default><family>sans-serif</family></default>"
	elog "</alias>"
	elog
}
