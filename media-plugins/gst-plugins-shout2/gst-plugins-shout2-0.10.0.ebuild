# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.10.0.ebuild,v 1.1 2005/12/05 21:30:29 zaheerm Exp $

inherit gst-plugins-good

DESCRIPTION="Plug-in to send data to an icecast server using libshout2"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-libs/libshout-2.0"
