# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lazarus/lazarus-0.9.12.ebuild,v 1.1 2006/02/23 19:43:27 gustavoz Exp $

inherit eutils

SLOT="0" # Note: Slotting Lazarus needs slotting fpc, see DEPEND.
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-linking-exception"
KEYWORDS="~amd64 ~ppc ~x86"
DESCRIPTION="Lazarus IDE is a feature rich visual programming environment emulating Delphi."
HOMEPAGE="http://www.lazarus.freepascal.org/"
IUSE=""
SRC_URI="mirror://sourceforge/lazarus/lazarus-0.9.12-0.tar.gz"

# Do not allow other versions of FPC.
DEPEND="~dev-lang/fpc-2.0.2
	>=media-libs/gdk-pixbuf-0.22.0-r3
	net-misc/rsync"

S=${WORKDIR}/lazarus

pkg_setup() {
	if ! built_with_use "dev-lang/fpc" source; then
		eerror "You need to build dev-lang/fpc with the 'source' USE flag"
		eerror "in order for lazarus to work properly."
		die "lazarus needs fpc built with the 'source' USE to work."
	fi
}

src_compile() {
	make -j1 all || die "make all failed!"
}

src_install() {
	# Note: Make install is broken and wont be fixed.
	einfo "Copying files. Please wait..."

	diropts -m0755
	dodir /usr/share/
	# Using rsync to avoid unnecessary copies and cleaning...
	# Note: *.o and *.ppu are needed
	rsync -a \
		--exclude="CVS"		--exclude=".cvsignore" \
		--exclude="*.ppw"	--exclude="*.ppl" \
		--exclude="*.ow"	--exclude="*.a"\
		--exclude="*.rst"	--exclude=".#*" \
		--exclude="*.~*"	--exclude="*.bak" \
		--exclude="*.orig"	--exclude="*.rej" \
		--exclude=".xvpics"	--exclude="*.compiled" \
		--exclude="killme*"	--exclude=".gdb_hist*" \
		${S} ${D}usr/share/ \
	|| die "Unable to copy files!"
}

pkg_preinst() {
	# Fixing permissions.
	find ${D} -name '*.sh' -exec chmod a+x {} \; || die "Failed to chmod *.sh files!"
	find ${D} -name '*.pl' -exec chmod a+x {} \; || die "Failed to chmod *.pl files!"

	# Symlinking binary
	dodir /usr/bin/
	dosym ../share/lazarus/startlazarus usr/bin/startlazarus || die "Symlinking startlazarus failed!"

	# Desktop entry.
	dodir /usr/share/pixmaps/
	dosym ../lazarus/images/mainicon.xpm usr/share/pixmaps/lazarus.xpm || die "Symlinking icon failed!"
	make_desktop_entry startlazarus "Lazarus IDE" "lazarus.xpm" || die "Failed making desktop entry!"
}
