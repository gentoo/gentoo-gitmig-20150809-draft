# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp-gapi/gtk-sharp-gapi-2.12.7-r5.ebuild,v 1.1 2009/01/05 17:18:19 loki_val Exp $

EAPI=2

GTK_SHARP_MODULE_DIR=parser

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RESTRICT="test"

src_compile() {
	gtk-sharp-module_src_compile
	GTK_SHARP_MODULE_DIR="../generator" gtk-sharp-module_src_compile
}

src_install() {
	local exec
	gtk-sharp-module_src_install
	GTK_SHARP_MODULE_DIR="../generator" gtk-sharp-module_src_install
	cd "${D}"/usr/bin
	for exec in *
	do
		ln -s ${exec} ${exec/2}
	done
}
