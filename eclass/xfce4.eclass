# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xfce4.eclass,v 1.1 2005/01/06 19:52:02 bcowan Exp $
# Author: Brad Cowan <bcowan@gentoo.org>

# Xfce4 Eclass
#
# Eclass to simplify Xfce4 package installation

ECLASS=xfce4
INHERITED="$INHERITED $ECLASS"

[[ ${BZIPPED} = "1" ]] \
    && COMPRESS=".tar.bz2" \
    || COMPRESS=".tar.gz"

if [[ ${GOODIES_PLUGIN} = "1" ]]; then
    [[ -z ${MY_P} ]] && MY_P="${PN}-plugin-${PV}"
    SRC_URI="http://download.berlios.de/xfce-goodies/${MY_P}${COMPRESS}"    
    XFCE_RDEPEND=">=xfce4-panel-${PV}"
fi

if [[ ${XFCE_META} = "1" ]]; then
    SRC_URI=""
else
    SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}${COMPRESS}"
fi

[[ -z ${LICENSE} ]] \
    && LICENSE="GPL-2"

HOMEPAGE="http://www.xfce.org/"
SLOT="0"
IUSE="${IUSE} doc debug"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	x11-libs/startup-notification
	>=dev-libs/dbh-1.0.20
	>=x11-themes/gtk-engines-xfce-2.2.4
	>=xfce-base/xfce-mcs-manager-${PV}
	${XFCE_RDEPEND}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	${XFCE_DEPEND}"

S="${WORKDIR}/${MY_P:-${P}}"

xfce4_src_compile() {
	if [[ "${DEBUG_OFF}" = "1" ]] && use debug; then
	    XFCE_CONFIG="${XFCE_CONFIG}" 
	elif use debug; then
	    XFCE_CONFIG="${XFCE_CONFIG} --enable-debug=yes"
	fi 
	
	econf ${XFCE_CONFIG} || die
    
	if [[ "${SINGLE_MAKE}" = "1" ]]; then
	    emake -j1 || die
	else
	    emake || die
	fi
}

xfce4_src_install() {
	if [[ "${WANT_EINSTALL}" = "1" ]]; then
	    einstall || die
	else
	    make DESTDIR=${D} install || die
	fi
	
	if use doc; then
	    dodoc ${XFCE_DOCS} AUTHORS INSTALL README COPYING ChangeLog HACKING NEWS THANKS TODO
	fi
}

EXPORT_FUNCTIONS src_compile src_install