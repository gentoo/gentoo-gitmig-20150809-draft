# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xfce4.eclass,v 1.11 2005/01/10 17:48:02 bcowan Exp $
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
    [[ -z ${XFCE_VERSION} ]] \
	&& XFCE_VERSION="4.1.99.3"
    XFCE_RDEPEND=">=xfce-base/xfce4-panel-${XFCE_VERSION}"
fi

if [[ ${PLUGIN} = "1" ]]; then
    MY_P="${PN}-plugin-${PV}"
    [[ -z ${XFCE_VERSION} ]] \
	&& XFCE_VERSION="4.1.99.3"
    XFCE_RDEPEND=">=xfce-base/xfce4-panel-${XFCE_VERSION}"
fi

[[ ${GOODIES} = "1" ]] \
    && SRC_URI="http://download.berlios.de/xfce-goodies/${MY_P:-${P}}${COMPRESS}"

[[ -n ${SRC_URI} ]] \
    || SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}${COMPRESS}"

[[ ${XFCE_META} = "1" ]] \
    && SRC_URI=""
    
[[ -z ${LICENSE} ]] \
    && LICENSE="GPL-2"

[[ -z ${HOMEPAGE} ]] \
    && HOMEPAGE="http://www.xfce.org/"

[[ -z ${XFCE_VERSION} ]] \
    && XFCE_VERSION="${PV}"

SLOT="0"
IUSE="${IUSE} doc debug"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	x11-libs/startup-notification
	>=dev-libs/dbh-1.0.20
	>=x11-themes/gtk-engines-xfce-2.2.4
	>=xfce-base/xfce-mcs-manager-${XFCE_VERSION}
	${XRDEPEND}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	${XDEPEND}"

[[ -z ${XFCE_S} ]] \
    && S="${WORKDIR}/${MY_P:-${P}}" \
    || S="${XFCE_S}"

xfce4_src_compile() {
	if [[ "${DEBUG_OFF}" = "1" ]] && use debug; then
	    XFCE_CONFIG="${XFCE_CONFIG}" 
	elif use debug; then
	    XFCE_CONFIG="${XFCE_CONFIG} --enable-debug=yes"
	fi 
	
	if [[ ${XFCE_META} = "1" ]]; then
	    einfo "Meta Build, Nothing to compile."   
	else
	    econf ${XFCE_CONFIG} || die
    
	    if [[ "${SINGLE_MAKE}" = "1" ]]; then
		emake -j1 || die
	    else
		emake || die
	    fi
	fi
}

xfce4_src_install() {
	if [[ ${XFCE_META} = "1" ]]; then
	    einfo "Meta Build, Nothing to install."
	else    
	    if [[ "${WANT_EINSTALL}" = "1" ]]; then
		einstall || die
	    else
		make DESTDIR=${D} install || die
	    fi
	
	    if use doc; then
		dodoc ${XFCE_DOCS} AUTHORS INSTALL README COPYING ChangeLog HACKING NEWS THANKS TODO
	    fi
	fi
}

EXPORT_FUNCTIONS src_compile src_install