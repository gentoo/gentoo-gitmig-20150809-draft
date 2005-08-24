# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmcd/xmcd-3.3.2.ebuild,v 1.12 2005/08/24 07:50:30 flameeyes Exp $

inherit eutils

IUSE="alsa encode vorbis"

SUPPLIB="cddb2supplib"
DESCRIPTION="Xmcd is a full-featured CD Player and Ripper software package."
HOMEPAGE="http://www.ibiblio.org/tkan/xmcd/"
SRC_URI="http://www.ibiblio.org/tkan/download/${PN}/${PV}/src/${P}.tar.gz
	 http://www.ibiblio.org/tkan/download/cddb2supp/${PV}/lib/linux-x86-libc6/${SUPPLIB}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"

# block media-libs/libcddb for now, see bug #90945
DEPEND="virtual/x11
	x11-libs/openmotif
	media-libs/flac
	!media-libs/libcddb
	alsa? ( media-libs/alsa-lib )
	encode? ( >=media-sound/lame-3.93.1 )
	vorbis? ( >=media-libs/libvorbis-1.0 )"

src_unpack() {

	ebegin "Unpacking ${P} source tarball"
		unpack ${P}.tar.gz > /dev/null
	eend 0

	if use x86
	then
		ebegin "Unpacking Gracenote CDDB² support package"
			unpack ${SUPPLIB}.tar.gz > /dev/null
		eend 0
	fi

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {

	einfo "Building xmcd..."
	xmkmf -a || die
	make CDEBUGFLAGS="${CDEBUGFLAGS} ${CFLAGS} -D_GNU_SOURCE" || die

}

src_install() {

	# shamelessly culled from SuSE .spec file...
	ebegin "Running install script"
		BATCH_BINDIR=${D}/usr/X11R6/bin \
		BATCH_LIBDIR=${D}/usr/X11R6/$(get_libdir)/X11 \
		BATCH_XMCDLIB=${D}/usr/X11R6/$(get_libdir)/X11/xmcd \
		BATCH_MANDIR=${D}/usr/X11R6/man/man1 \
		BATCH_CDDBDIR=${D}/var/lib/xmcd/cddb \
		BATCH_DISCOGDIR=${D}/var/lib/xmcd/discog \
		sh install.sh -n -b || die
	eend 0

	for lib in libcddb.so.1 libcddb.a libcddbkey1.a libcddbkey2.a; do
		dolib cddb_d/${lib}
	done

	dosym libcddbkey2.a /usr/$(get_libdir)/libcddbkey.a
	dosym libcddb.so.1 /usr/$(get_libdir)/libcddb.so

	# a small fixup...
	rm -rf ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/docs
	dodir etc
	dosym ../usr/X11R6/$(get_libdir)/X11/xmcd/config /etc/xmcd

	# move binaries to correct place
	ebegin "Moving binaries to target location"
		(cd ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/bin-*;
		 sed -e "s@${D}@@g" \
		 < ${D}/usr/X11R6/bin/.xmcd_start > start
		 cp start ${D}/usr/X11R6/bin/.xmcd_start
		 sed -e "s@${D}@@" < README > README.tmp
		 mv README.tmp README )
		rm -f ${D}/usr/X11R6/bin/*
		(cd ${D}/usr/X11R6/bin; \
		 ln -s ../lib/X11/xmcd/bin-*/start xmcd; \
		 ln -s ../lib/X11/xmcd/bin-*/start cda)
		cp ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/config/common.cfg \
		   ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/config/cdrom
		for i in config/config.sh scripts/genidx ; do
		 sed -e "s@${D}@@g" \
		 < ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/$i \
		 > ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/$i.tmp
		 mv ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/$i.tmp \
		    ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/$i
		done
	eend 0

	ebegin "Fixing ownership and permissions"
		# fix ownership
		chown -R root:0 ${D}
		# remove setuid bit
		chmod 0755 ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/bin-*/{cda,xmcd,start,gobrowser}
		chmod 0755 ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/config/config.sh
		chmod 0755 ${D}/usr/X11R6/$(get_libdir)/X11/xmcd/scripts/genidx
		# change perms
		chmod 0644 ${D}/var/lib/xmcd/discog/index.html
		chmod 0644 ${D}/var/lib/xmcd/discog/*/*/index.html
	eend 0

	if use x86
	then
		ebegin "Adding Gracenote CDDB² support"
			exeinto /usr/X11R6/$(get_libdir)/X11/xmcd/lib-Linux-i686
			doexe ${WORKDIR}/${P}/cddb_d/libcddb.so.1
			dosym libcddb.so.1 /usr/X11R6/$(get_libdir)/X11/xmcd/lib-Linux-i686/libcddb.so
		eend 0
	fi

	# install documentation
	dodoc docs_d/*
	dosym ../../../../../usr/share/doc/${P} /usr/X11R6/$(get_libdir)/X11/xmcd/docs
}

pkg_postinst() {

	einfo
	einfo "Don't forget to run ${ROOT}etc/xmcd/config.sh"
	einfo "as root to configure your CD devices!"
	einfo

}

pkg_postrm() {

	einfo
	einfo "Old discographies found in ${ROOT}var/lib/xmcd can safely be deleted."
	einfo "Old CD configurations in ${ROOT}etc/xmcd can safely be deleted."
	einfo

}
