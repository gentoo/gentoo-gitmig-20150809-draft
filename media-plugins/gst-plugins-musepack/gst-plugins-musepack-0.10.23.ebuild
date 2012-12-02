# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.23.ebuild,v 1.1 2012/12/02 18:00:49 eva Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=media-sound/musepack-tools-444"
DEPEND="${RDEPEND}"
