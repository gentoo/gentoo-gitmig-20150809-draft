# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-back-art/gnustep-back-art-0.9.5_pre20041030.ebuild,v 1.1 2004/10/31 05:40:49 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/core/back"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="libart_lgpl back-end component for the GNUstep GUI Library."
HOMEPAGE="http://www.gnustep.org"

KEYWORDS="~ppc"
SLOT="0"
LICENSE="LGPL-2.1"

PROVIDE="virtual/gnustep-back"

IUSE="${IUSE} opengl xim doc"
DEPEND="${GNUSTEP_GUI_DEPEND}
	=gnustep-base/gnustep-gui-${PV}
	opengl? ( virtual/opengl virtual/glu )
	gnustep-libs/artresources
	=gnustep-base/mknfonts-0.5
	virtual/xft
	=media-libs/freetype-2.1*
	=media-libs/libart_lgpl-2.3*"
RDEPEND="${DEPEND}
${DOC_RDEPEND}"

src_compile() {
	egnustep_env

	use opengl && myconf="--enable-glx"
	myconf="$myconf `use_enable xim`"
	myconf="$myconf --enable-server=x11"
	myconf="$myconf --enable-graphics=art --with-name=art"
	econf $myconf || die "configure failed"

	egnustep_make
}

