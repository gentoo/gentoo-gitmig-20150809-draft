# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-volume/gkrellm-volume-2.1.9.ebuild,v 1.11 2007/03/12 15:26:46 lack Exp $

inherit gkrellm-plugin

IUSE=""
DESCRIPTION="A mixer control plugin for gkrellm"
HOMEPAGE="http://gkrellm.luon.net/volume.phtml"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha amd64"

S=${WORKDIR}/${PN}

PLUGIN_SO=volume.so

