# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.8.2.ebuild,v 1.9 2004/10/01 06:12:32 geoman Exp $

inherit gst-plugins

KEYWORDS="x86 ppc alpha sparc hppa amd64 ~ia64 mips ppc64"

IUSE=""
# should we depend on a kernel (?)
DEPEND="virtual/kernel"
