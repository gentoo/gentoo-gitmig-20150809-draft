# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libpciaccess/libpciaccess-0.10.2.ebuild,v 1.4 2009/05/28 16:45:51 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Library providing generic access to the PCI bus and devices"
IUSE=""
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~x86"

CONFIGURE_OPTIONS="--with-pciids-path=/usr/share/misc"
