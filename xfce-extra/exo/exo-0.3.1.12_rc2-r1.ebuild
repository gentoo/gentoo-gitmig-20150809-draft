# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.1.12_rc2-r1.ebuild,v 1.1 2006/12/11 04:34:45 nichoj Exp $

inherit xfce44 versionator

MY_PV="$(replace_version_separator 4 '')"
MY_P="${PN}-${MY_PV}"

xfce44_beta
xfce44_extra_package

DESCRIPTION="Libraries for Xfce 4 designed for application development"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug doc python"

RDEPEND="
	>=dev-util/intltool-0.31
	>=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.6.4
	>=x11-libs/gtk+-2.6
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-plugins-${XFCE_MASTER_VERSION}
	doc? ( >=dev-util/gtk-doc-1.0 )
	python? (
		>=dev-lang/python-2.2
		>=dev-python/pygtk-2.4.0
	)"
DEPEND="${RDEPEND}
	dev-python/pygtk
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}"

S="${WORKDIR}/${MY_P}"

XFCE_CONFIG="
	$(use_enable doc gtk-doc) \
	$(use_enable python) \
	$(use_enable debug) \
	--enable-mcs-plugin
"
