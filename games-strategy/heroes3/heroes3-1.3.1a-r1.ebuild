# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/heroes3/heroes3-1.3.1a-r1.ebuild,v 1.10 2006/04/17 13:29:32 wolf31o2 Exp $

# 	[x] Base Install Required (+4 MB) 
#	[x] Scenarios (+7 MB)
#	[x] Sounds and Graphics (+118 MB)
#	[x] Music (+65 MB)
#	[x] Videos (+147 MB)
#	--------------------
#	Total 341 MB

inherit games

DESCRIPTION="Heroes of Might and Magic III : The Restoration of Erathia - turn-based 2-D medieval combat"
HOMEPAGE="http://www.lokigames.com/products/heroes3/"

# Since I do not have a PPC machine to test with, I will leave the PPC stuff in
# here so someone else can stabilize loki_setupdb and loki_patch for PPC and
# then KEYWORD this appropriately.
SRC_URI="x86? ( mirror://lokigames/${PN}/${P}-cdrom-x86.run )
	ppc? ( mirror://lokigames/${PN}/${P}-ppc.run )"

LICENSE="LOKI-EULA"
SLOT="0"
IUSE="nocd maps music sounds videos"
KEYWORDS="x86"
RESTRICT="strip"

DEPEND="virtual/libc
	games-util/loki_patch"
RDEPEND="sys-libs/lib-compat-loki"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	use nocd && ewarn "The full installation takes about 341 MB of space!"
}

src_unpack() {
	unpack_makeself
}

src_install() {
	cdrom_get_cds hiscore.tar.gz
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/${PN}
	insinto ${dir}
	doins ${CDROM_ROOT}/{Heroes_III_Tutorial.pdf,README,icon.{bmp,xpm}}

	if use nocd; then
		dodir ${dir}/{maps,mp3,data} ${dir}/data/video
		cp -r ${CDROM_ROOT}/{data,maps,mp3} ${Ddir} || die "copying data"
	else
		dodir ${dir}/data
		use maps && insinto ${dir}/maps && dodir ${dir}/maps && doins ${CDROM_ROOT}/maps/*
		use music && insinto ${dir}/mp3 && dodir ${dir}/mp3 && doins ${CDROM_ROOT}/mp3/*
		use sounds && insinto ${dir}/data && doins ${CDROM_ROOT}/data/{*.lod,*.snd}
		use videos && insinto ${dir}/data/video && dodir ${dir}/data/video && doins ${CDROM_ROOT}/data/video/*
	fi

	cd ${Ddir}
	tar -zxf ${CDROM_ROOT}/hiscore.tar.gz || die "unpacking hiscore"

	cd ${S}
	loki_patch --verify patch.dat
	loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	games_make_wrapper heroes3 ./heroes3 "${dir}" "${dir}"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	newicon ${CDROM_ROOT}/icon.xpm heroes3.xpm

	prepgamesdirs
	make_desktop_entry heroes3 "Heroes of Might and Magic III" "heroes3.xpm"

	if use x86; then
		einfo "Linking libs provided by 'sys-libs/lib-compat-loki' to '${dir}'."
		dosym /lib/loki_ld-linux.so.2 ${dir}/ld-linux.so.2 && \
		dosym /usr/lib/loki_libc.so.6 ${dir}/libc.so.6 && \
		dosym /usr/lib/loki_libnss_files.so.2 ${dir}/libnss_files.so.2 || die "dosym failed"
	fi

	einfo "Changing 'hiscore.dat' to be writeable for group 'games'."
	fperms g+w "${dir}/data/hiscore.dat" || die "fperms failed"
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " heroes3"
}
