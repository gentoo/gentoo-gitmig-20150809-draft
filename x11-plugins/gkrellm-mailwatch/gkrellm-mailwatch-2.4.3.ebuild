# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-mailwatch/gkrellm-mailwatch-2.4.3.ebuild,v 1.9 2007/04/04 17:10:04 gustavoz Exp $

inherit gkrellm-plugin

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="A GKrellM2 plugin that shows the status of additional mail boxes"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/mailwatch.phtml"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc sparc x86"

PLUGIN_SO=mailwatch.so

