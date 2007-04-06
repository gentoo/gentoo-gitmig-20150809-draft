# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lazarus/lazarus-0.9.22.ebuild,v 1.1 2007/04/06 00:14:25 truedfx Exp $

inherit eutils

FPCVER="2.0.4"

SLOT="0" # Note: Slotting Lazarus needs slotting fpc, see DEPEND.
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-linking-exception"
KEYWORDS="~amd64 ~ppc ~x86"
DESCRIPTION="Lazarus IDE is a feature rich visual programming environment emulating Delphi."
HOMEPAGE="http://www.lazarus.freepascal.org/"
IUSE=""
SRC_URI="mirror://sourceforge/lazarus/${P}-0.tar.gz"

DEPEND="~dev-lang/fpc-${FPCVER}
	net-misc/rsync
	>=x11-libs/gtk+-2.0"

S=${WORKDIR}/${PN}

pkg_setup() {
	if ! built_with_use "dev-lang/fpc" source; then
	    eerror "You need to build dev-lang/fpc with the 'source' USE flag"
	    eerror "in order for lazarus to work properly."
	    die "lazarus needs fpc built with the 'source' USE to work."
	fi
}

src_unpack() {
	# check for broken fpc.cfg
	# don't check in pkg_setup since it won't harm binpkgs
	if grep -q '^[ 	]*-Fu.*/lcl$' /etc/fpc.cfg
	then
		eerror "Your /etc/fpc.cfg automatically adds a LCL directory"
		eerror "to the list of unit directories. This will break the"
		eerror "build of lazarus."
		die "don't set the LCL path in /etc/fpc.cfg"
	fi

	unpack ${A}
	sed -e "s/@FPCVER@/${FPCVER}/" "${FILESDIR}"/${PN}-0.9.20-fpcsrc.patch \
		> "${T}"/fpcsrc.patch || die "could not sed fpcsrc patch"

	cd "${S}"
	epatch "${T}"/fpcsrc.patch
	epatch "${FILESDIR}"/${PN}-iconcrash.patch
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
