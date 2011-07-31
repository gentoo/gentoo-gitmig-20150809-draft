# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-esd/gst-plugins-esd-0.10.30.ebuild,v 1.1 2011/07/31 03:18:09 leio Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to output sound to esound"
KEYWORDS="~alpha ~amd64 ~amd64-linux ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=media-sound/esound-0.2.12
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
