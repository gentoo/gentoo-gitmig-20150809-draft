# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-mailwatch/gkrellm-mailwatch-2.4.2.ebuild,v 1.11 2007/03/09 19:28:40 lack Exp $

inherit gkrellm-plugin

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="A GKrellM2 plugin that shows the status of additional mail boxes"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/mailwatch.phtml"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

PLUGIN_SO=mailwatch.so

