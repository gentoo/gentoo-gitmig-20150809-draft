# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Geoffrey Antos <geoffrey@andrews.edu>
# $Header: /var/cvsroot/gentoo-x86/net-www/apache2/apache2-2.0.40.ebuild,v 1.2 2002/08/29 04:38:06 drobbins Exp $

S="${WORKDIR}/httpd-${PV}"

# Short one-line description of this package.
DESCRIPTION="The Famous Apache Web Server, Version 2.0.x"

SRC_URI="http://www.apache.org/dist/httpd/httpd-${PV}.tar.gz"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.apache.org"

# License of the package. This must match the name of file(s) in
# /usr/portage/licenses/. For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE="ASL-1.1"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
RDEPEND="virtual/glibc
	>=dev-libs/mm-1.1.3
	>=sys-libs/gdbm-1.8
	>=dev-libs/expat-1.95.2"

DEPEND=">=sys-devel/perl-5.6.1 ${RDEPEND}"

src_compile() {
	# Most open-source packages use GNU autoconf for configuration.
	# You should use something similar to the following lines to
	# configure your package before compilation. The "|| die" portion
	# at the end will stop the build process if the command fails.
	# You should use this at the end of critical commands in the build
	# process.	(Hint: Most commands are critical, that is, the build
	# process should abort if they aren't successful.)

	select_modules_config || \
		die "Couldn't find apache-builtin-mods config file"
	./configure \
		--host=${CHOST} \
		--prefix=/usr/local/apache2 \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/apache2 \
		--with-perl=/usr/bin/perl \
		--datadir=/home/httpd \
		--localstatedir=/var \
		--enable-suexec \
		--with-suexec-uidmin=1000 \
		--with-suexec-gidmin=100 \
		${MY_BUILTINS} \
			|| die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	# Install documentation.
	dodoc CHANGES INSTALL LICENSE README

	insinto /etc/conf.d; newins ${FILESDIR}/apache.confd apache2
	exeinto /etc/init.d; newexe ${FILESDIR}/apache.rc6 apache2
	insinfo /etc/apache2; newins ${FILESDIR}/apache2-builtin-mods
}

parse_modules_config() {
	local filename=$1
	local name=""
	local dso=""
	local disable=""
	[ -f ${filename} ] || return 1
	einfo ">>> using ${filename} for builtins..."
	for i in `cat $filename | sed "s/^#.*//"` ; do
		if [ $i == "-" ] ; then
			disable="true"
		elif [ -z "$name" ] && [ ! -z "`echo $i | grep "mod_"`" ] ; then
			name=`echo $i | sed "s/mod_//"`
		elif [ "$disable" ] && ( [ $i == "static" ] || [ $i == "shared" ] ) ; then
			MY_BUILTINS="${MY_BUILTINS} --disable-$name"
			name="" ; disable=""
		elif [ $i == "static" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=yes"
			name="" ; disable=""
		elif [ $i == "shared" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=shared"
			name="" ; disable=""
		fi
	done
	einfo ">>> Here is your custom config line:\n${MY_BUILTINS}"
}

select_modules_config() {
	parse_modules_config /etc/apache2/apache2-builtin-mods || \
	parse_modules_config ${FILESDIR}/apache2-builtin-mods || \
	return 1
}
