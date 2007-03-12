# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-vaiobright/gkrellm-vaiobright-2.5.ebuild,v 1.5 2007/03/12 15:11:43 lack Exp $

inherit gkrellm-plugin

IUSE=""

MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Superslim VAIO LCD Brightness Control Plugin for Gkrellm"
SRC_URI="http://nerv-un.net/~dragorn/code/${MY_P}.tar.gz"
HOMEPAGE="http://nerv-un.net/~dragorn/"

DEPEND=">=app-admin/gkrellm-2.0"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 -*"

PLUGIN_SO=vaiobright.so

