# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-cbg-editor/eclipse-cbg-editor-0.3.7.ebuild,v 1.4 2004/07/20 18:56:00 karltk Exp $

inherit eclipse-ext

DESCRIPTION="Syntax color highlighting editor for Eclipse, using jEdit syntax files"
HOMEPAGE="http://gstaff.org/colorEditor/"
SRC_URI="http://dev.gentoo.org/~karltk/projects/eclipse/distfiles/cbg-editor-${PV}-gentoo.tar.bz2"
LICENSE="grindstaff"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes"
RDEPEND=">=dev-util/eclipse-sdk-3.0.0"
DEPEND="${RDEPEND}
	jikes? ( >=dev-java/jikes-1.19 )
	app-arch/unzip"
S=${WORKDIR}/cbg.editor_${PV}

src_compile() {
	local myc

	use jikes && myc="${myc} -Dbuild.compiler=jikes"

	ant ${myc} build.jars || die "Failed to compile"
	ant ${myc} zip.plugin || die "Failed to zip"

	cd result
	mkdir plugins
	unzip cbg.editor_${PV} -d plugins
}

src_install() {
	eclipse-ext_require-slot 3 || "Failed to find suitable Eclipse installation (3.0.x)"
	eclipse-ext_create-ext-layout source || die "Failed to create directory layout"
	eclipse-ext_install-plugins result/plugins/* || die "Failed to install plugin"
}
