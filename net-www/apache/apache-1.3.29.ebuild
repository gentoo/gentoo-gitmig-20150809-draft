# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-1.3.29.ebuild,v 1.6 2004/04/01 23:34:50 zul Exp $

inherit eutils

#IUSE="ipv6 pam"
IUSE="pam"

mod_ssl_ver=2.8.16

S=${WORKDIR}/${PN}_${PV}
DESCRIPTION="The Apache Web Server"
HOMEPAGE="http://www.apache.org http://www.modssl.org"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
SRC_URI="http://httpd.apache.org/dist/httpd/apache_${PV}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2
	ftp://ftp.modssl.org/source/mod_ssl-${mod_ssl_ver}-${PV}.tar.gz"
#	ipv6? http://motoyuki.bsdclub.org/data/IPv6/apache-${PV}-mod_ssl-${mod_ssl_ver}-v6-20021004.diff.gz"
# The mod_ssl archive is only for providing the EAPI patch in here.
# You should install the net-www/mod_ssl package for the actual DSO.

DEPEND="dev-lang/perl <sys-libs/db-4.1
	>=dev-libs/mm-1.1.3
	>=sys-libs/gdbm-1.8
	>=dev-libs/expat-1.95.2"
LICENSE="Apache-1.1"
SLOT="1"

#Standard location for Gentoo Linux
DATADIR="/var/www/localhost"

src_unpack() {
	local myssl
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff || die

	#Obsolete 'head -1' and 'tail -1' calls.
	perl -pi -e 's|tail -1|tail -n 1|;' \
		src/Configure src/helpers/getuid.sh
	perl -pi -e 's|head -1|head -n 1|;' \
		src/Configure src/helpers/buildinfo.sh src/helpers/fmn.sh

	#Make apachectl read /etc/conf.d/apache
	epatch ${FILESDIR}/apache-1.3.27-apachectl.patch || die

	sed -i "s:/usr/local/bin/perl5:/usr/bin/perl:" \
		htdocs/manual/search/manual-index.cgi

	# setup eapi...
	myssl=${WORKDIR}/mod_ssl-${mod_ssl_ver}-${PV}
	cp ${myssl}/pkg.eapi/*.h src/include
	cp ${myssl}/pkg.eapi/*.c src/ap
	epatch ${myssl}/pkg.eapi/eapi.patch || die "eapi"

	# set a reasonable MM_CORE_PATH location..
	sed -i 's:logs/mm:/var/cache/apache-mm/mm:' \
		src/include/httpd.h

#	# thanks drey@rt.mipt.ru for these two ...
#	if use ipv6; then
#		zcat ${DISTDIR}/apache-${PV}-mod_ssl-${mod_ssl_ver}-v6-20021004.diff.gz | patch -p0 || die
#	fi

	if use pam; then
		epatch ${FILESDIR}/suexec_pam_gentoo.patch || die
	fi

	# Detect db4 correctly
	epatch ${FILESDIR}/apache-1.3.27_db4_gentoo.patch || die

	# Fixes mod_auth_db compile breakages with db4.0
	epatch ${FILESDIR}/apache-1.3.29_mod_auth_db.patch
}

src_compile() {
	local myconf mycflags
	mycflags="${CFLAGS}"
	unset CFLAGS ; unset CXXFLAGS
#	use ipv6 && myconf="--enable-rule=INET6"

	select_modules_config || die "determining modules"

	#-DBUFFERED_LOGS
	OPTIM="${mycflags} -DHARD_SERVER_LIMIT=${HARD_SERVER_LIMIT:=512} \
		-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
	LIBS="-lgdbm -lpthread" \
	EAPI_MM=SYSTEM \
	./configure \
		--prefix=/usr \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sbindir=/usr/sbin \
		--libexecdir=/usr/lib/apache \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/apache/conf \
		--datadir=${DATADIR} \
		--cgidir=${DATADIR}/cgi-bin \
		--iconsdir=${DATADIR}/icons \
		--htdocsdir=${DATADIR}/htdocs \
		--manualdir=/usr/share/doc/${PF}/manual \
		--includedir=/usr/include/apache \
		--localstatedir=/var \
		--runtimedir=/var/run \
		--logfiledir=/var/log/apache \
		--proxycachedir=/var/cache/apache \
		--serverroot=/etc/apache \
		\
		--target=apache \
		--server-uid=apache \
		--server-gid=apache \
		--enable-rule=EAPI \
		--enable-rule=SHARED_CHAIN \
		--with-perl=/usr/bin/perl \
		\
		${MY_BUILTINS} \
		\
		--enable-suexec \
		--suexec-uidmin=1000 \
		--suexec-gidmin=100 \
		--suexec-caller=apache \
		--suexec-userdir=public_html \
		--suexec-docroot=/home \
		--suexec-safepath="/bin:/usr/bin" \
		--suexec-logfile=/var/log/apache/suexec_log \
		\
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	local myfile

	GID=`getent group apache | cut -d: -f3`
	if [ -z "${GID}" ]; then
		einfo "Using default GID of 81 for Apache"
		GID=81
	fi

	make install-quiet root=${D} || die
	dodoc ABOUT_APACHE Announcement INSTALL* LICENSE* README* WARNING* \
		${FILESDIR}/robots.txt

	#protect the suexec binary
	fowners root:${GID} /usr/sbin/suexec
	fperms 4710 /usr/sbin/suexec

	# nice support scripts..
	for myfile in apacheaddmod apachedelmod \
		apachelogserverstatus apachesplitlogfile
	do
		exeinto /usr/sbin
		doexe ${FILESDIR}/$myfile
	done

	# setup links in /etc/apache..
	cd ${D}/etc/apache
	ln -sf ../../usr/lib/apache modules
	# apxs needs this to pickup the right lib for install..
	ln -sf ../../usr/lib lib
	ln -sf ../../var/log/apache logs
	ln -sf ../../usr/lib/apache-extramodules extramodules

	# drop in a convenient link to the manual
	dosym /usr/share/doc/${PF}/manual ${DATADIR}/htdocs/manual

	# deprecated config files, empty dirs..
	rm -f ${D}/etc/apache/conf/apache.conf.default
	rm -f ${D}/etc/apache/conf/access.conf*
	rm -f ${D}/etc/apache/conf/srm.conf*

	# now the config files..
	insinto /etc/apache/conf
	doins ${FILESDIR}/conf/commonapache.conf
	doins ${FILESDIR}/conf/apache.conf

	# Added by Jason Wever <weeve@gentoo.org>
	# A little sedfu to fix bug #7172 for sparc64s
	if [ ${ARCH} = "sparc" ]
	then
		sed -i -e '15a\AcceptMutex fcntl' \
		${D}/etc/apache/conf/apache.conf
	fi

	insinto /etc/apache/conf/vhosts
	doins ${FILESDIR}/conf/VirtualHomePages.conf
	doins ${FILESDIR}/conf/DynamicVhosts.conf
	doins ${FILESDIR}/conf/Vhosts.conf

	exeinto /etc/init.d ; newexe ${FILESDIR}/apache.rc6 apache
	insinto /etc/conf.d ; newins ${FILESDIR}/apache.confd apache
	insinto /etc/apache ; doins ${FILESDIR}/apache-builtin-mods

	if use pam; then
		insinto /etc/pam.d ; newins ${FILESDIR}/suexec.pam suexec
	fi

	#empty dirs
	keepdir /var/cache/apache /var/cache/apache-mm /usr/lib/apache-extramodules /etc/apache/conf/addon-modules /var/log/apache
}

pkg_postinst() {
	# these are in baselayout now; it will not hurt to leave them here though
	# moved to pkg_postinst by jnelson, moved to pkg_preinst by lostlogic
	getent group apache >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		groupadd -g 81 apache || die "problem adding group apache"
	fi

	# usermod returns 2 on user-exists-but-no-flags-given
	#usermod apache &>/dev/null
	#if [ $? != 2 ]; then
	getent passwd apache >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		useradd -u 81 -g apache -s /bin/false -d /var/www/localhost -c "apache" apache
		assert "problem adding user apache"
	fi

	einfo
	einfo "Please remember to update your config files in /etc/apache"
	einfo "as --datadir has been changed to ${DATADIR}!"
	einfo
}

parse_modules_config() {
	local filename=$1
	local name=""
	local dso=""
	local disable=""
	[ -f ${filename} ] || return 1
	einfo "Using ${filename} for builtins."
	for i in `cat $filename | sed "s/^#.*//"` ; do
		if [ $i == "-" ] ; then
			disable="true"
		elif [ -z "$name" ] && [ ! -z "`echo $i | grep "mod_"`" ] ; then
			name=`echo $i | sed "s/mod_//"`
		elif [ "$disable" ] && ( [ $i == "static" ] || [ $i == "shared" ] ) ; then
			MY_BUILTINS="${MY_BUILTINS} --disable-module=$name"
			name="" ; disable=""
		elif [ $i == "static" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-module=$name --disable-shared=$name"
			name="" ; disable=""
		elif [ $i == "shared" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-module=$name --enable-shared=$name"
			name="" ; disable=""
		fi
	done
}

select_modules_config() {
	parse_modules_config /etc/apache/apache-builtin-mods || \
	parse_modules_config ${FILESDIR}/apache-builtin-mods || \
	return 1
}
