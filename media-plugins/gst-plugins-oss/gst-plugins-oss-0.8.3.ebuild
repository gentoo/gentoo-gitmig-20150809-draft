# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.8.3.ebuild,v 1.4 2005/01/25 20:08:03 corsair Exp $

inherit gst-plugins

KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

# should we depend on a kernel (?)
DEPEND="virtual/os-headers"
