# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment-cvs/enlightenment-cvs-0.17.20021027.ebuild,v 1.8 2002/12/15 10:44:24 bjb Exp $

IUSE="pic X mmx truetype opengl"

ECVS_SERVER="cvs.enlightenment.sourceforge.net:/cvsroot/enlightenment"
ECVS_MODULE="e17"
ECVS_CVS_OPTIONS="-dP"

DEPEND="app-admin/fam-oss 
	dev-libs/libxml2
	dev-libs/libpcre
	dev-lang/ferite
	media-libs/imlib2"

inherit cvs

DESCRIPTION="Enlightenment Window Manager"
SRC_URI=""
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
S=${WORKDIR}/${ECVS_MODULE}
E_PREFIX=/usr/e17

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

	dodir ${E_PREFIX}
	[ -e ${E_PREFIX} ] || ln -sf ${D}/${E_PREFIX} ${E_PREFIX}
}

src_install() {
	# anytime you see --> echo "all:"$'\n\t'"echo done">test/Makefile
	# it means i disabled the test building ... i could do a sed on that
	# Makefile to make it work, but its just a test app ... who cares ...
	# for some reason, `make LDFLAGS="-L -L -L"` doesnt work, so its punted

	local baseconf
	local addconf
	baseconf="--prefix=${E_PREFIX} --with-gnu-ld --enable-shared"
	use pic	&&	baseconf="${baseconf} --with-pic"

	# the stupid gettextize script prevents non-interactive mode, so we hax it
	mkdir ${S}/hax
	cp `which gettextize` ${S}/hax/ || die "could not copy gettextize"
	cp ${S}/hax/gettextize ${S}/hax/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${S}/hax/gettextize.old > ${S}/hax/gettextize

	# find our haxed script first, the -config scripts 2nd, everything else last
	PATH="${S}/hax:${E_PREFIX}/bin:${PATH}"
	CFLAGS="${CFLAGS} -I${E_PREFIX}/include -I${E_PREFIX}/include/ewd"

	############
	### libs ###
	############

	### imlib2 ###
	# mmx support in imlib2 makes other things complain it would seem ...
	# *shrug*, worked for me ;D
	cd ${S}/libs/imlib2
	addconf="--disable-mmx"
	use X		&& addconf="${addconf} --with-x"
#	use mmx		&& addconf="${addconf} --enable-mmx"
	use truetype	&& addconf="${addconf} --with-ttf=/usr"
	env USER=BS ./autogen.sh ${baseconf} ${addconf} || die "could not autogen imlib2"
	make || die "could not make imlib2"
	make install DESTDIR=${D} || die "could not install imlib2"

	### edb ###
	cd ${S}/libs/edb
	./autogen.sh ${baseconf} || die "could not autogen edb"
	make || die "could not make edb"
	make install DESTDIR=${D} || die "could not install edb"

	### imlib2_loaders ###
	cd ${S}/libs/imlib2_loaders
	use X		&& addconf="${addconf} --with-x"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen imlib2_loaders"
	make || die "could not make imlib2_loaders"
	make install DESTDIR=${D} || die "could not install imlib_loaders"

	### evas ###
	cd ${S}/libs/evas
	addconf=
	use X		&& addconf="${addconf} --with-x"
	use truetype	&& addconf="${addconf} --with-ttf=/usr"
	use opengl	&& addconf="${addconf} --with-gl=/usr"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen evas"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make evas"
	make install DESTDIR=${D} || die "could not install evas"

	### ewd ###
	cd ${S}/libs/ewd
	./autogen.sh ${baseconf} || die "could not autogen ewd"
	make || die "could not make ewd"
	make install DESTDIR=${D} || die "could not install ewd"

	### ebits ###
	cd ${S}/libs/ebits
	./autogen.sh ${baseconf} || die "could not autogen ebits"
	make || die "could not make ebits"
	make install DESTDIR=${D} || die "could not install ebits"

	### ecore ###
	cd ${S}/libs/ecore
	addconf=
	use X		&& addconf="${addconf} --with-x"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen ecore"
	make || die "could not make ecore"
	make install DESTDIR=${D} || die "could not install ecore"

	### estyle ###
	cd ${S}/libs/estyle
	./autogen.sh ${baseconf} || die "could not autogen estyle"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make estyle"
	make install DESTDIR=${D} || die "could not install estyle"

	### etox ###
	cd ${S}/libs/etox
	./autogen.sh ${baseconf} || die "could not autogen etox"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make etox"
	make install DESTDIR=${D} || die "could not install etox"

	### ebg ###
	cd ${S}/libs/ebg
	./autogen.sh ${baseconf} || die "could not autogen ebg"
	make || die "could not make ebg"
	make install DESTDIR=${D} || die "could not install ebg"

	### ewl ###
	cd ${S}/libs/ewl
	env USER=BS ./autogen.sh ${baseconf} || die "could not autogen ewl"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make ewl"
	make install DESTDIR=${D} || die "could not install ewl"

	############
	### apps ###
	############

	### etcher ###
	cd ${S}/apps/etcher
	addconf="--disable-nls --with-included-gettext"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen etcher"
	make CFLAGS="${CFLAGS} -levas" top_builddir=`pwd` || die "could not make etcher"
	make install DESTDIR="${D}" top_builddir=`pwd` || die "could not install etcher"

	### ebony ###
	cd ${S}/apps/ebony
	./autogen.sh ${baseconf} || die "could not autogen ebony"
	make || die "could not make ebony"
	make install DESTDIR="${D}" || die "could not install ebony"

	### med ###
	cd ${S}/apps/med
	addconf=
	use X           && addconf="${addconf} --with-x"
	./autogen.sh ${baseconf} ${addconf} || die "could not autogen med"
	make || die "could not build med"
	make install DESTDIR="${D}" || die "could not install med"

	### efsd ###
	cd ${S}/apps/efsd
	./autogen.sh ${baseconf} || die "could not autogen efsd"
	make || die "could not build efsd"
	make install DESTDIR="${D}" || die "could not install efsd"

	### ebindings ###
	cd ${S}/apps/ebindings
	./autogen.sh ${baseconf} || die "could not autogen ebindings"
	make || die "could not build ebindings"
	make install DESTDIR="${D}" || die "could not install ebindings"

	### e ###
	cd ${S}/apps/e
	# hack it a little ;D
	cp configure.ac configure.ac.old
	sed -e 's:AC_MSG_ERROR(Cannot detect:#:' \
	 -e 's:intl/Makefile::' \
	 -e 's:po/Makefile.in::' \
		configure.ac.old > configure.ac
	cp Makefile.am Makefile.am.old
	sed -e 's:intl po::' Makefile.am.old > Makefile.am
	./autogen.sh ${baseconf} || die "could not autogen e"
	cp Makefile Makefile.old
	sed -e 's:m4   ::' Makefile.old > Makefile
	make || die "could not build e"
	make install DESTDIR="${D}" || die "could not install e"

	# remove improper stuff
	cd ${D}
	rm -rf `find -name CVS`
	rm -rf '@aclocaldir@'

	# make an env.d entry
	insinto /etc/env.d
	echo "PATH=${E_PREFIX}/bin" > e.env.d
	echo "LDPATH=${E_PREFIX}/lib" >> e.env.d
	newins e.env.d 50enlightenment
}

pkg_preinst() {
	# clean up symlink
	[ -L ${E_PREFIX} ] && rm -f ${E_PREFIX}
}
