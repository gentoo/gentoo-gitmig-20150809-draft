# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/subversion/subversion-0.34.0.ebuild,v 1.2 2003/12/20 20:16:46 pauldv Exp $

inherit elisp-common libtool

DESCRIPTION="A compelling replacement for CVS"
SRC_URI="http://svn.collab.net/tarballs/${P}.tar.gz"
HOMEPAGE="http://subversion.tigris.org/"
PYTHON_DIR=`python-config | sed -e "s,\(.*-L\)\(/usr/lib.*\)\(/config.*\),\2,"`

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE="ssl apache2 berkdb python emacs"

S=${WORKDIR}/${PN}-${PV}

#Allow for custion repository locations
if [ "${SVN_REPOS_LOC}x" = "x" ]; then
	SVN_REPOS_LOC="/var/svn"
fi

#
#
# Note that to disable the server part of subversion you need to specify
# USE="-berkdb" emerge subversion.
#
#

DEPEND="python? ( >=dev-lang/python-2.0 )
	apache2? ( >=net-www/apache-2.0.48 )
	!apache2? ( !>=net-www/apache-2* )
	!dev-libs/apr
	<sys-devel/autoconf-2.58
	python? ( >=dev-lang/swig-1.3.16 )
	>=net-misc/neon-0.24.2
	berkdb? ( =sys-libs/db-4* )"

pkg_setup() {
	if has_version '<dev-util/subversion-0.34.0' && [ "${SVN_DUMPED}" == "" ]; then
		einfo ""
		ewarn ":  Now you have $(best_version subversion)"
		ewarn " Subversion had chaged the repository filesystem schema from 0.28.0."
		ewarn " So you MUST dump your repositories before upgrading."
		ewarn ""
		ewarn "After doing so call emerge with SVN_DUMPED=1 emerge !!"
		einfo ""
		einfo "More details on dumping:"
		einfo "http://svn.collab.net/repos/svn/trunk/notes/repos_upgrade_HOWTO"
		die "ensure that you dump your repository first"
	fi

	if use apache2; then
		einfo "The apache2 subversion module will be built, and libapr from the"
		einfo "apache package will be used instead of the included"
	else
		einfo "Please note that subversion and apache2 cannot be installed"
		einfo "simultaneously without specifying the apache2 use flag. This is"
		einfo "because subversion installs its own libapr and libapr-util in that"
		einfo "case."
	fi
}

src_unpack() {
	cd ${WORKDIR}
	unpack ${PN}-${PV}.tar.gz
	cd ${S}

	patch -p1 <${FILESDIR}/subversion-db4.patch
	export WANT_AUTOCONF_2_5=1
	elibtoolize
	autoconf
	(cd apr; autoconf)
	(cd apr-util; autoconf)
#	sed -i -e 's,\(subversion/svnversion/svnversion\)\(>.*svn-revision.txt\),echo "external" \2,' Makefile.in
}

src_compile() {
	local myconf

	cd ${S}
	use ssl && myconf="${myconf} --with-ssl"
	use ssl || myconf="${myconf} --without-ssl"

	use apache2 && myconf="${myconf} --with-apxs=/usr/sbin/apxs2 \
		--with-apr=/usr --with-apr-util=/usr"
	use apache2 || myconf="${myconf} --without-apxs"

	use berkdb && myconf="${myconf} --with-berkeley-db"
	use berkdb || myconf="${myconf} --without-berkeley-db"

	use python && myconf="${myconf} --with-python=/usr/bin/python --with-swig"
	use python || myconf="${myconf} --without-python --without-swig"

	econf ${myconf} \
		--with-neon=/usr \
		--disable-experimental-libtool \
		--disable-mod-activation ||die "configuration failed"


	# build subversion, but do it in a way that is safe for paralel builds
	# Also apparently the included apr does have a libtool that doesn't like
	# -L flags. So not specifying it at all when not building apache modules
	# and only specify it for internal parts otherwise
	if use apache2; then
		( emake external-all && emake LT_LDFLAGS="-L${D}/usr/lib" local-all ) || die "make of subversion failed"
	else
		( emake external-all && emake local-all ) || die "make of subversion failed"
	fi

	#building fails without the apache apr-util as includes are wrong.
	#Also the python bindings do not work without db installed
	if use python; then
		if use berkdb; then
			if use apache2; then
				emake swig-py || die "subversion python bindings failed"
			else
				emake SVN_APR_INCLUDES="-I${S}/apr/include -I${S}/apr-util/include" swig-py || die "subversion python bindings failed"
			fi
		fi
	fi
	if use emacs; then
		emacs -batch -f batch-byte-compile contrib/client-side/vc-svn.el
		emacs -batch -f batch-byte-compile contrib/client-side/psvn/psvn.el
	fi
}


src_install () {
	use apache2 && mkdir -p ${D}/etc/apache2/conf

	make DESTDIR=${D} install || die "Installation of subversion failed"
	if [ -e ${D}/usr/lib/apache2 ]; then
		mv ${D}/usr/lib/apache2 ${D}/usr/lib/apache2-extramodules
	fi

	if use python; then
		if use berkdb; then
			make install-swig-py DESTDIR=${D} DISTUTIL_PARAM=--prefix=${D}  LD_LIBRARY_PATH="-L${D}/usr/lib" || die "Installation of subversion python bindings failed"
			# install cvs2svn
			dobin tools/cvs2svn/cvs2svn.py
			mv ${D}/usr/bin/cvs2svn.py ${D}/usr/bin/cvs2svn
			doman tools/cvs2svn/cvs2svn.1

			# move python bindings
			mkdir -p ${D}${PYTHON_DIR}/site-packages
			cp -r tools/cvs2svn/rcsparse ${D}${PYTHON_DIR}/site-packages
			mv ${D}/usr/lib/svn-python/svn ${D}${PYTHON_DIR}/site-packages
			mv ${D}/usr/lib/svn-python/libsvn ${D}${PYTHON_DIR}/site-packages
			rmdir ${D}/usr/lib/svn-python
		fi
	fi

	dodoc BUGS COMMITTERS COPYING HACKING INSTALL README
	dodoc CHANGES
	dodoc tools/xslt/svnindex.css tools/xslt/svnindex.xsl

	# install documentation
	docinto notes
	for f in notes/*
	do
		[ -f ${f} ] && dodoc ${f}
	done

	cd ${S}
	echo "installing html book"
	dohtml -r doc/book/book/book.html doc/book/book/styles.css doc/book/book/images

	# install emacs lisps
	if use emacs; then
		insinto /usr/share/emacs/site-lisp/subversion
		doins contrib/client-side/psvn/psvn.el*
		doins  contrib/client-side/vc-svn.el*

		elisp-site-file-install ${FILESDIR}/70svn-gentoo.el
	fi



	#Install apache module config
	if use apache2; then
		mkdir -p ${D}/etc/apache2/conf/modules.d
		cat <<EOF >${D}/etc/apache2/conf/modules.d/47_mod_dav_svn.conf
<IfDefine SVN>
	<IfModule !mod_dav_svn.c>
		LoadModule dav_svn_module	extramodules/mod_dav_svn.so
	</IfModule>
	<Location /svn/repos>
		DAV svn
		SVNPath ${SVN_REPOS_LOC}/repos
		AuthType Basic
		AuthName "Subversion repository"
		AuthUserFile ${SVN_REPOS_LOC}/conf/svnusers
		Require valid-user
	</Location>
</IfDefine>
EOF
	fi
}

pkg_postinst() {

	use emacs && elisp-site-regen
	if use berkdb; then
		if use apache2; then
			einfo "Subversion has multiple server types. To enable the http based version"
			einfo "you must edit /etc/conf.d/apache2 to include both \"-D DAV\" and \"-D SVN\""
			einfo ""
		fi
		einfo "A repository needs to be created using the ebuild ${PN} config command"
		einfo ""
		einfo "If you upgraded from an older version of berkely db and experience"
		einfo "problems with your repository then run the following command:"
		einfo "    su apache -c \"db4_recover -h /path/to/repos\""

		if use apache2; then
			einfo ""
			einfo "To allow web access a htpasswd file needs to be created using the"
			einfo "following command:"
			einfo "   htpasswd2 -m -c ${SVN_REPOS_LOC}/conf/svnusers USERNAME"
		fi

	else
		einfo "Your subversion is client only as the server is only build when"
		einfo "the berkdb flag is set"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

pkg_config() {
	if [ ! -x /usr/bin/svnadmin ]; then
		die "You seem to only have build the subversion client"
	fi
	einfo ">>> Initializing the database in ${SVN_REPOS_LOC}..."
	if [ -f ${SVN_REPOS_LOC}/repos ] ; then
		echo "A subversion repository already exists and I will not overwrite it."
		echo "Delete ${SVN_REPOS_LOC}/repos first if you're sure you want to have a clean version."
	else
		mkdir -p ${SVN_REPOS_LOC}/conf
		einfo ">>> Populating repository directory ..."
		# create initial repository
		/usr/bin/svnadmin create ${SVN_REPOS_LOC}/repos

		einfo ">>> Setting repository permissions ..."
		chown -Rf apache:apache ${SVN_REPOS_LOC}/repos
		chmod -Rf 755 ${SVN_REPOS_LOC}/repos
	fi
}
