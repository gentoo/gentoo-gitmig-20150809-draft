# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lazarus/lazarus-0.9.26-r2.ebuild,v 1.1 2009/04/23 21:05:03 truedfx Exp $

EAPI=2

inherit eutils

FPCVER="2.2.4"

SLOT="0" # Note: Slotting Lazarus needs slotting fpc, see DEPEND.
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-linking-exception"
KEYWORDS="~amd64 ~ppc ~x86"
DESCRIPTION="Lazarus IDE is a feature rich visual programming environment emulating Delphi."
HOMEPAGE="http://www.lazarus.freepascal.org/"
IUSE=""
SRC_URI="mirror://sourceforge/lazarus/${P}-0.tgz"

DEPEND="~dev-lang/fpc-${FPCVER}[source]
	net-misc/rsync
	>=x11-libs/gtk+-2.0"
RDEPEND="${DEPEND}
	!=gnome-base/librsvg-2.16.1"
DEPEND="${DEPEND}
	>=sys-devel/binutils-2.19.1-r1"

S=${WORKDIR}/${PN}

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

	cd "${S}"
	epatch "${FILESDIR}"/${P}-fpcsrc.patch
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
		--exclude="debian"  --exclude="COPYING*" \
		--exclude="*.app" \
		"${S}" "${D}"usr/share \
	|| die "Unable to copy files!"

	dosym ../share/lazarus/startlazarus /usr/bin/startlazarus
	dosym ../lazarus/images/ide_icon48x48.png /usr/share/pixmaps/lazarus.png

	make_desktop_entry startlazarus "Lazarus IDE" "lazarus" || die "Failed making desktop entry!"
}
