# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment-cvs/enlightenment-cvs-0.17.20021026.ebuild,v 1.7 2002/10/26 21:38:54 vapier Exp $

IUSE="pic X mmx truetype opengl nls"

ECVS_SERVER="cvs.enlightenment.sourceforge.net:/cvsroot/enlightenment"
ECVS_MODULE="e17"
ECVS_CVS_OPTIONS="-dP"

inherit cvs

DESCRIPTION="Enlightenment Window Manager"
SRC_URI=""
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
S=${WORKDIR}/${ECVS_MODULE}
E_PREFIX=/usr/e17

DEPEND="app-admin/fam-oss
	dev-libs/libxml2
	dev-libs/libpcre
	dev-lang/ferite
	media-libs/imlib2"
RDEPEND="nls? ( sys-devel/gettext )"

pkg_setup() {
	ewarn "A NOTE ABOUT THE COMPILE STAGE:"
	echo
	ewarn "Do NOT report a bug about this ebuild on bugs.gentoo.org"
	ewarn "Chances are that the problem lies with e17, and since its"
	ewarn "in such an unstable state, Gentoo isnt going to spend time"
	ewarn "on it :).  If e17 doesnt work for you, then use 0.16.5"
	echo
	einfo "If you are 100% sure the problem is with the ebuild, then"
	einfo "e-mail me at vapier@gentoo.org"
	echo
	einfo "Also, if you feel something isnt installed and it should"
	einfo "be, then also send me an e-mail ;)"
}

src_compile() {
	# anytime you see --> echo "all:"$'\n\t'"echo done">test/Makefile
	# it means i disabled the test building ... i could do a sed on that
	# Makefile to make it work, but its just a test app ... who cares ...
	# for some reason, `make LDFLAGS="-L -L -L"` doesnt work, so its punted

	local baseconf
	local addconf
	baseconf="--prefix=${E_PREFIX} --with-gnu-ld --enable-shared"
	use pic	&&	baseconf="${baseconf} --with-pic"

	local cflags
	local ldflags
	local ldflags_src
	local ldflags_lib
	cflags="${CFLAGS} -I${S}/libs/e{bg,bits,core,db,style,tox,vas,wd}/src"
	cflags="${cflags} -I${S}/apps/efsd/efsd"
	ldflags_src="${LDFLAGS} -L${S}/libs/e{bg,bits,core,db,style,tox,vas,wd}/src"
	ldflags_lib="${ldflags_src}/.libs"

	# the stupid gettextize script prevents non-interactive mode, so we hax it
	mkdir ${S}/hax
	cp `which gettextize` ${S}/hax/ || die "could not copy gettextize"
	cp ${S}/hax/gettextize ${S}/hax/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${S}/hax/gettextize.old > ${S}/hax/gettextize

	local path="${S}/hax"
	for d in ebg ebits edb ecore evas etox ewd ; do
		path="${S}/libs/${d}:${path}"
	done
	path="${S}/apps/efsd:${path}"
	PATH="${path}:${PATH}"

	############
	### libs ###
	############
	ldflags="${ldflags_src}"

	### imlib2 ###
	cd ${S}/libs/imlib2
	addconf=
	use X		&& addconf="${addconf} --with-x"
	use mmx		&& addconf="${addconf} --enable-mmx"
	use truetype	&& addconf="${addconf} --with-ttf=/usr"
	env USER=BS ./autogen.sh ${baseconf} ${addconf} || die "could not autogen imlib2"
	make || die "could not make imlib2"

	### edb ###
	cd ${S}/libs/edb
	./autogen.sh ${baseconf} || die "could not autogen edb"
	make || die "could not make edb"

	### imlib2_loaders ###
	cd ${S}/libs/imlib2_loaders
	use X		&& addconf="${addconf} --with-x"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen imlib2_loaders"
	make || die "could not make imlib2_loaders"

	### evas ###
	cd ${S}/libs/evas
	addconf=
	use X		&& addconf="${addconf} --with-x"
	use truetype	&& addconf="${addconf} --with-ttf=/usr"
	use opengl	&& addconf="${addconf} --with-gl=/usr"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen evas"
	echo "all:"$'\n\t'"echo done">test/Makefile
	make || die "could not make evas"

	### ewd ###
	cd ${S}/libs/ewd
	./autogen.sh ${baseconf} || die "could not autogen ewd"
	make || die "could not make ewd"

	### ebits ###
	cd ${S}/libs/ebits
	ln -s ${S}/libs/evas/src/Evas.h
	./autogen.sh ${baseconf} || die "could not autogen ebits"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not make ebits"

	### ecore ###
	cd ${S}/libs/ecore
	addconf=
	use X		&& addconf="${addconf} --with-x"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen ecore"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not make ecore"

	### estyle ###
	cd ${S}/libs/estyle
	./autogen.sh ${baseconf} || die "could not autogen estyle"
	echo "all:"$'\n\t'"echo done">test/Makefile
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not make estyle"

	### etox ###
	cd ${S}/libs/etox
	./autogen.sh ${baseconf} || die "could not autogen etox"
	echo "all:"$'\n\t'"echo done">test/Makefile
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}"|| die "could not make etox"

	### ebg ###
	cd ${S}/libs/ebg
	./autogen.sh ${baseconf} || die "could not autogen ebg"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not make ebg"

	### ewl ###
	cd ${S}/libs/ewl
	env USER=BS ./autogen.sh ${baseconf} || die "could not autogen ewl"
	echo "all:"$'\n\t'"echo done">test/Makefile
	make CFLAGS="${cflags}" LDFLAGS="${ldflags} -lestyle" || die "could not make ewl"

	############
	### apps ###
	############
	ldflags="${ldflags_libs}"

	### etcher ###
	cd ${S}/apps/etcher
	addconf=
	use nls		|| addconf="${addconf} --disable-nls --with-included-gettext"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen etcher"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" top_builddir=`pwd` || die "could not make etcher"

	### ebony ###
	cd ${S}/apps/ebony
	./autogen.sh ${baseconf} || die "could not autogen ebony"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not make ebony"

	### med ###
	cd ${S}/apps/med
	addconf=
	use X           && addconf="${addconf} --with-x"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen med"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not build med"

	### efsd ###
	ldflags="${ldflags_src}"
	cd ${S}/apps/efsd
	./autogen.sh ${baseconf} || die "could not autogen efsd"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not build efsd"

	### ebindings ###
	ldflags="${ldflags_lib}"
	cd ${S}/apps/ebindings
	./autogen.sh ${baseconf} || die "could not autogen ebindings"
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not build ebindings"

	### e ###
	ldflags="${ldflags_src} -L${S}/apps/efsd/efsd"
	cd ${S}/apps/e
	# hack it a little ;D
	cp configure.ac configure.ac.old
	sed -e 's:AC_MSG_ERROR(Cannot detect:#:' \
	 -e 's:intl/Makefile::' \
	 -e 's:po/Makefile.in::' \
		configure.ac.old > configure.ac
	./autogen.sh ${baseconf} || die "could not autogen e"
	cp Makefile Makefile.old
	sed -e 's:m4  po::' \
		Makefile.old > Makefile
	make CFLAGS="${cflags}" LDFLAGS="${ldflags}" || die "could not build e"
}

src_install() {
	into ${E_PREFIX}
	dodir ${E_PREFIX}/share
	rm -rf `find -name CVS`

	### e ###
	cd ${S}/apps/e
	dodir ${E_PREFIX}/share/enlightenment
	dobin client/e_ipc_client src/.libs/enlightenment tools/.libs/*
	mv data ${D}/${E_PREFIX}/share/enlightenment/

	### ebindings ebony etcher med ###
	cd ${S}/apps
	dodir ${E_PREFIX}/share/ebony
	dodir ${E_PREFIX}/share/etcher
	for e in ebindings ebony etcher med ; do
		dobin ${e}/src/${e}
	done
	mv ebony/pixmaps ${D}/${E_PREFIX}/share/ebony/
	mv etcher/{examples,pixmaps} ${D}/${E_PREFIX}/share/etcher/

	### efsd ###
	cd ${S}/apps/efsd
	dodir ${E_PREFIX}/share/efsd/
	dobin efsd/.libs/efsd efsd-config tools/efsdsh
	dolib.a efsd/.libs/*.a
	dolib.so efsd/.libs/libefsd.so.0.0.0
	dosym ${E_PREFIX}/lib/libefsd.so.0.0.0 ${E_PREFIX}/lib/libefsd.so.0
	dosym ${E_PREFIX}/lib/libefsd.so.0.0.0 ${E_PREFIX}/lib/libefsd.so
	mv tools/{magic.txt,filetypes.dtd,filetypes.xml} ${D}/${E_PREFIX}/share/efsd/

	# prep the library dirs
	cd ${S}/libs
	rm -rf `find -name test`

	# install the .a libraries
	dolib.a e{bg,bits,core,db,style,tox,vas,wd,wl}/src/.libs/*.a \
		ewl/plugins/fx/{fade_{in,out},glow}/.libs/*.a \
		imlib2/{filters,libltdl,loaders,src}/.libs/*.a \
		imlib2_loaders/{libltdl,src}/.libs/*.a

	# install the .so libraries
	dolib.so ewl/plugins/fx/{fade_{in,out},glow}/.libs/*.so \
		imlib2/{filters,loaders}/.libs/*.so \
		imlib2_loaders/src/.libs/*.so
	for libdir in e{bg,bits,core,db,style,tox,vas,wd,wl} imlib2 ; do
		cd ${S}/libs/${libdir}/src/.libs
		local reallib=`ls *.so.?.?.?`
		dolib.so ${reallib}
		for symlib in *.so* ; do
			[ "${reallib}" != "${symlib}" ] && \
				dosym ${E_PREFIX}/lib/${reallib} ${E_PREFIX}/lib/${symlib}
		done
	done
	cd ${S}/libs

	# install the binaries/scripts
	dobin `find -name '*-config'`
	dobin ebg/tools/.libs/* \
		edb/tools/edb_gtk_ed/.libs/* \
		edb/tools/.libs/* \
		ewl/tools/ewl_config/.libs/*

	# make an env.d entry for our libraries/binaries
	dodir /etc/env.d
	echo "LDPATH=${E_PREFIX}/lib" > e.env.d
	echo "PATH=${E_PREFIX}/bin" >> e.env.d
	insinto /etc/env.d
	newins e.env.d 50enlightenment
}
