# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mad/gst-plugins-mad-1.0.3.ebuild,v 1.1 2012/12/05 22:51:44 eva Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~arm ~hppa ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/libmad-0.15.1b"
DEPEND="${RDEPEND}"
