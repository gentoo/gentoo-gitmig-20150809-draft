# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.22.ebuild,v 1.2 2011/09/20 04:18:53 phajdan.jr Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33
	>=media-sound/musepack-tools-444"
DEPEND="${RDEPEND}"
