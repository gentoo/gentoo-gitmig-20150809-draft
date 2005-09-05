# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.8.11.ebuild,v 1.1 2005/09/05 17:56:42 zaheerm Exp $

inherit gst-plugins

DESCRIPTION="Plug-in to send data to an icecast server using libshout2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/libshout-2.0"
