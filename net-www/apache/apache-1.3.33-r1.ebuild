# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-1.3.33-r1.ebuild,v 1.17 2005/04/03 20:33:13 beu Exp $

# Gentoo ARCH teams
#
# Do NOT mark this ebuild as stable unless the corresponding mod_ssl package
# can also be marked as stable on your arch.
#
# Thanks,
# stuart@gentoo.org

inherit eutils fixheadtails

IUSE="pam ssl"

mod_ssl_dep=2.8.21
mod_ssl_ver=2.8.21-1.3.32

S=${WORKDIR}/${PN}_${PV}
DESCRIPTION="The Apache Web Server"
HOMEPAGE="http://www.apache.org http://www.modssl.org"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"
SRC_URI="mirror://apache/httpd/apache_${PV}.tar.gz
	ftp://ftp.modssl.org/source/mod_ssl-${mod_ssl_ver}.tar.gz
	http://dev.gentoo.org/~stuart/apache/apache-patches-1.3.33.tar.bz2"


# The mod_ssl archive is only for providing the EAPI patch in here.
# You should install the net-www/mod_ssl package for the actual DSO.

DEPEND="dev-lang/perl
	<=sys-libs/db-4.1
	>=dev-libs/mm-1.1.3
	>=sys-libs/gdbm-1.8
	>=dev-libs/expat-1.95.2
	=sys-libs/db-1*
	selinux? ( sec-policy/selinux-apache )"

PDEPEND="ssl? ( =net-www/mod_ssl-${mod_ssl_dep} )"

LICENSE="Apache-2.0"
SLOT="1"

#Standard location for Gentoo Linux
DATADIR="/var/www/localhost"

src_unpack() {
	local myssl
	unpack ${A} || die
	cd ${S} || die

	EPATCH_SUFFIX="patch"
	epatch ${WORKDIR}/apache-patches-1.3.33 || die

	#Obsolete 'head -1' and 'tail -1' calls.
	ht_fix_file src/Configure src/helpers/getuid.sh \
		src/helpers/fmn.sh src/helpers/buildinfo.sh

	# setup eapi...
	myssl=${WORKDIR}/mod_ssl-${mod_ssl_ver}
	cp ${myssl}/pkg.eapi/*.h src/include
	cp ${myssl}/pkg.eapi/*.c src/ap
	epatch ${myssl}/pkg.eapi/eapi.patch || die "eapi"

	# set a reasonable MM_CORE_PATH location..
	sed -i -e 's:logs/mm:/var/cache/apache-mm/mm:' \
		src/include/httpd.h
}

src_compile() {
	local myconf mycflags
	mycflags="${CFLAGS}"
	unset CFLAGS ; unset CXXFLAGS

	select_modules_config || die "determining modules"

	#-DBUFFERED_LOGS
	OPTIM="${mycflags} -DHARD_SERVER_LIMIT=${HARD_SERVER_LIMIT:=512} \
		-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
	LIBS="-ldb -lgdbm -lgdbm_compat -lpthread" \
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
		--target=apache \
		--server-uid=apache \
		--server-gid=apache \
		--with-perl=/usr/bin/perl \
		--enable-rule=EAPI \
		--enable-rule=SHARED_CHAIN \
		${MY_BUILTINS} \
		--enable-suexec \
		--suexec-uidmin=1000 \
		--suexec-gidmin=100 \
		--suexec-caller=apache \
		--suexec-userdir=public_html \
		--suexec-docroot=/var/www \
		--suexec-safepath="/bin:/usr/bin" \
		--suexec-logfile=/var/log/apache/suexec_log \
		\
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	local myfile

	GID=`id -g apache`
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
