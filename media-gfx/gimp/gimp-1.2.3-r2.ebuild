# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.2.3-r2.ebuild,v 1.6 2002/07/16 11:36:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GIMP"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.2/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"

SLOT="1.2"
KEYWORDS="x86 ppc"
LICENSE="GPL"

DEPEND="nls? ( sys-devel/gettext )
	sys-devel/autoconf
	sys-devel/automake
	=x11-libs/gtk+-1.2*
	>=media-libs/mpeg-lib-1.3.1
	aalib? ( >=media-libs/aalib-1.2 )
	perl? ( >=dev-perl/PDL-2.2.1 
		>=dev-perl/Parse-RecDescent-1.80 
		>=dev-perl/gtk-perl-0.7004 )
	python? ( >=dev-lang/python-2.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

RDEPEND="=x11-libs/gtk+-1.2*
	aalib? ( >=media-libs/aalib-1.2 )
	perl? ( >=dev-perl/PDL-2.2.1 >=dev-perl/Parse-RecDescent-1.80 >=dev-perl/gtk-perl-0.7004 )
	python? ( >=dev-lang/python-2.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

src_unpack() {
	unpack ${A}
	
	cd ${S}/plug-ins/common
	# compile with nonstandard psd_save plugin
	cp ${FILESDIR}/psd_save.c .
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die
	cd ${S}
	
	if [ -f ${ROOT}/usr/share/gettext/config.rpath ] ; then
		cp -f ${ROOT}/usr/share/gettext/config.rpath ${S}
	else
		touch ${S}/config.rpath
		chmod 0755 ${S}/config.rpath
	fi
	
	echo ">>> Reconfiguring package..."
	export WANT_AUTOMAKE_1_4=1
	export WANT_AUTOCONF_2_5=1
	automake --add-missing
	autoreconf --install --symlink &> ${T}/autoreconf.log || ( \
		echo "DEBUG: working directory is: `pwd`" >>${T}/autoreconf.log
		eerror "Reonfigure failed, please attatch the contents of:"
		eerror
		eerror "  ${T}/autoreconf.log"
		eerror
		eerror "in your bugreport."
		# we need an error here, else the ebuild do not die
		exit 1
	) || die "running autoreconf failed"
	touch plug-ins/common/gimp-1.2.3.tar.bz2
}

src_compile() {
	local myconf=""
	local mymake=""
	local myvars=""
	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	fi

	if [ -z "`use perl`" ] ; then
		myconf="${myconf} --disable-perl"
	else
		myconf="${myconf} --enable-perl"
	fi

	if [ -z "`use python`" ] ; then
		myconf="${myconf} --disable-python"
	else
		myconf="${myconf} --enable-python"
	fi

	if [ -z "`use aalib`" ] ; then
		mymake="LIBAA= AA="
	fi

	if [ -z "`use gnome`" ] ; then
		mymake="${mymake} HELPBROWSER="
	fi

	./configure --host=${CHOST} \
			--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--sysconfdir=/etc \
			--with-mp \
			--with-threads \
			--disable-debug \
			${myconf} || die

	if [ -z "`use aalib`" ] ; then 
		# Horrible automake brokenness
		cp plug-ins/common/Makefile plug-ins/common/Makefile.orig
		cat plug-ins/common/Makefile.orig | \
			sed 's/CML_explorer$(EXEEXT) aa/CML_explorer$(EXEEXT)/' \
			> plug-ins/common/Makefile
	fi

	# Doesn't work with -j 4 (hallski)
	make ${mymake} || die
}

src_install() {

	local mymake="" 
	if [ -z "`use aalib`" ] ; then
		mymake="LIBAA= AA="
	fi

	if [ -z "`use gnome`" ] ; then
		mymake="${mymake} HELPBROWSER="
	fi
  
	dodir /usr/lib/gimp/1.2/plug-ins
	
	make prefix=${D}/usr \
		 gimpsysconfdir=${D}/etc/gimp/1.2 \
		 mandir=${D}/usr/share/man \
		 infodir=${D}/usr/share/info \
		 PREFIX=${D}/usr \
		 INSTALLPRIVLIB=${D}/usr/lib/perl5 \
		 INSTALLSCRIPT=${D}/usr/bin \
		 INSTALLSITELIB=${D}/usr/lib/perl5/site_perl \
		 INSTALLBIN=${D}/usr/bin \
		 INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		 INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		 ${mymake} \
		 install || die

	dosym gimp-1.2 /usr/bin/gimp
	#this next line closes bug #810
	dosym gimptool-1.2 /usr/bin/gimptool
	
	preplib /usr
	
	dodoc AUTHORS COPYING ChangeLog* *MAINTAINERS README* TODO
	dodoc docs/*.txt docs/*.ps docs/Wilber* docs/quick_reference.tar.gz
	dohtml -r devel-docs
	docinto devel
	dodoc devel-docs/*.txt
}

