# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tkcvs/tkcvs-6.4-r2.ebuild,v 1.12 2004/07/15 00:12:28 agriffis Exp $


DESCRIPTION="TkCVS"
SRC_URI="http://www.twobarleycorns.net/${P}.tar.gz"
HOMEPAGE="http://www.twobarleycorns.net/tkcvs.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
IUSE=""

RDEPEND=">=dev-lang/tk-8.1.1"

src_compile() {
	echo "It's tcl, you don't need to compile.  ;)"
}

src_install() {
	dodir /usr/lib /usr/bin /usr/lib/tkcvs/ /usr/lib/tkcvs/bitmaps

	# We need to do this 'cause the tcl install requires X to be running
	# and the user that runs emerge to have DISPLAY set and working
	cat tkcvs/tkcvs.blank | sed -e {s/_TCDIR_/"\/usr\/lib"/} \
		> ${D}/usr/bin/tkcvs
	chmod 755 ${D}/usr/bin/tkcvs
	chmod 755 ${S}/tkdiff/tkdiff
	dobin tkdiff/tkdiff

	insinto /usr/lib/tkcvs
	doins \
		tkcvs/modtree.tcl tkcvs/cvs.tcl tkcvs/reports.tcl \
		tkcvs/tooltips.tcl tkcvs/tkcvs_def.tcl \
		tkcvs/gen_log.tcl tkcvs/logcanvas.tcl tkcvs/dialog.tcl \
		tkcvs/import.tcl tkcvs/merge.tcl tkcvs/errors.tcl \
		tkcvs/static.tcl tkcvs/search.tcl tkcvs/filebrowse.tcl \
		tkcvs/modules.tcl tkcvs/commit.tcl tkcvs/modbrowse.tcl \
		tkcvs/workdir.tcl tkcvs/help.tcl tkcvs/tclIndex

	insinto /usr/lib/tkcvs/bitmaps
	doins 	bitmaps/edit.gif bitmaps/files.gif \
		bitmaps/loop-glasses.gif bitmaps/clean.gif \
		bitmaps/clear.gif bitmaps/tclfish.gif bitmaps/diff.gif \
		bitmaps/fileview.gif bitmaps/dir.gif \
		bitmaps/loop-half.gif bitmaps/conflict.gif \
		bitmaps/patches.gif bitmaps/fileedit.gif \
		bitmaps/arrow_hl_up.gif bitmaps/branchtag.gif \
		bitmaps/branch.gif bitmaps/checkin.gif bitmaps/tag.gif \
		bitmaps/logfile.gif bitmaps/refresh.gif \
		bitmaps/arrow_dn.gif bitmaps/remove.gif bitmaps/mod.gif \
		bitmaps/import.gif bitmaps/patchfile.gif \
		bitmaps/checkout.gif bitmaps/add.gif \
		bitmaps/mergebranch.gif bitmaps/tags.gif \
		bitmaps/adir.gif bitmaps/arrow_up.gif bitmaps/arrow.gif \
		bitmaps/unedit.gif bitmaps/delete.gif bitmaps/mdir.gif \
		bitmaps/modules.gif bitmaps/ball.gif bitmaps/who.gif \
		bitmaps/export.gif bitmaps/loop.gif \
		bitmaps/modbrowse.gif bitmaps/mergediff.gif \
		bitmaps/arrow_hl_dn.gif bitmaps/amod.gif \
		bitmaps/tclfish.xbm bitmaps/tkcvs32.xbm \
		bitmaps/tkcvs48.xbm bitmaps/tkcvs32_mask.xbm \
		bitmaps/tclfish_fly.xbm bitmaps/modbrowse.xbm \
		bitmaps/trace.xbm

	newman tkcvs/tkcvs.n tkcvs.1

	# Add docs...this is important
	dodoc CHANGELOG COPYING FAQ README.tkcvs README.windows

	docinto tkdiff
	dodoc tkdiff/PATCHES tkdiff/COPYING

	docinto tkcvs
	dodoc tkcvs/vendor.readme
}
