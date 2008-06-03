# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/redet/redet-8.9.ebuild,v 1.2 2008/06/03 01:21:03 darkside Exp $

DESCRIPTION="A regular expression development and execution tool"
HOMEPAGE="http://www.billposer.org/Software/redet.html"

SRC_URI="http://www.billposer.org/Software/Downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.3
	>=dev-lang/tk-8.3
	dev-tcltk/itk
	dev-tcltk/iwidgets"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	local MANUAL_PN=`echo ${PN} | cut -c 1 | tr [:lower:] [:upper:]``echo ${PN} | cut -c 2-`

	newbin ${PN}.tcl ${PN}
	doman ${PN}.1
	dodoc AUTHORS CREDITS INSTALL README-General README-MacOSX \
	 SampleClasses.utf8 \
	 SampleCustomCharacterWidgetDefinition_Armenian \
	 SampleCustomCharacterWidgetDefinition_Greek \
	 SampleNewStyleDotRedetRC_Elaborate SampleNewStyleDotRedetRC_Simple
	dohtml -r Manual
	dosym doc/${P}/html /usr/share/${MANUAL_PN}
}
