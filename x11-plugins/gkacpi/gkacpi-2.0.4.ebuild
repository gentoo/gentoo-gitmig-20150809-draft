# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkacpi/gkacpi-2.0.4.ebuild,v 1.3 2007/06/04 18:05:53 opfer Exp $

inherit gkrellm-plugin

IUSE=""
DESCRIPTION="ACPI monitor for Gkrellm"
SRC_URI="mirror://sourceforge/gkacpi/${PN}2-0.4.tar.gz"
HOMEPAGE="http://gkacpi.sf.net"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

S="${WORKDIR}/${PN}2-0.4"

PLUGIN_SO=gkacpi2.so

