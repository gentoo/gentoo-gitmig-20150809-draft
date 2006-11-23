# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lazarus/lazarus-0.9.20.ebuild,v 1.2 2006/11/23 07:14:50 truedfx Exp $

inherit eutils

SLOT="0" # Note: Slotting Lazarus needs slotting fpc, see DEPEND.
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-linking-exception"
KEYWORDS="~amd64 ~ppc ~x86"
DESCRIPTION="Lazarus IDE is a feature rich visual programming environment emulating Delphi."
HOMEPAGE="http://www.lazarus.freepascal.org/"
IUSE=""
SRC_URI="mirror://sourceforge/lazarus/${P}-0.tar.gz"

DEPEND="~dev-lang/fpc-2.0.4
	net-misc/rsync
	>=x11-libs/gtk+-2.0"

S=${WORKDIR}/lazarus

pkg_setup() {
	if ! built_with_use "dev-lang/fpc" source; then
	    eerror "You need to build dev-lang/fpc with the 'source' USE flag"
	    eerror "in order for lazarus to work properly."
	    die "lazarus needs fpc built with the 'source' USE to work."
	fi
}

src_compile() {
	LCL_PLATFORM=gtk2 emake -j1 || die "make failed!"
}

src_install() {
	diropts -m0755
	dodir /usr/share
	# Using rsync to avoid unnecessary copies and cleaning...
	# Note: *.o and *.ppu are needed
	rsync -a \
		--exclude="CVS"     --exclude=".cvsignore" \
		--exclude="*.ppw"   --exclude="*.ppl" \
		--exclude="*.ow"    --exclude="*.a"\
		--exclude="*.rst"   --exclude=".#*" \
		--exclude="*.~*"    --exclude="*.bak" \
		--exclude="*.orig"  --exclude="*.rej" \
		--exclude=".xvpics" --exclude="*.compiled" \
		--exclude="killme*" --exclude=".gdb_hist*" \
		"${S}" "${D}"usr/share \
	|| die "Unable to copy files!"

	dosym ../share/lazarus/startlazarus /usr/bin/startlazarus
	dosym ../lazarus/images/mainicon.xpm /usr/share/pixmaps/lazarus.xpm

	make_desktop_entry startlazarus "Lazarus IDE" "lazarus.xpm" || die "Failed making desktop entry!"
}

pkg_postinst() {
	ewarn "Although this version of Lazarus uses GTK2, its default interface"
	ewarn "for projects is still GTK1. Please make sure to change this if you"
	ewarn "wish to build GTK2 applications."
}
