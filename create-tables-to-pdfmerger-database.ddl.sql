-- Date: 11-13-2018
-- Author: Jeevan Pulugu
-- Description: DDL Script to add tables to pdfmerger database
CREATE TABLE [dbo].[projects]
(
 [ID]                  int IDENTITY (1, 1) NOT NULL ,
 [project_name]        varchar(50) NOT NULL ,
 [project_description] varchar(200) NULL ,
 [created_by]          int NOT NULL ,
 [effective_start]     datetime NOT NULL ,
 [effective_end]       datetime NULL ,

 CONSTRAINT [PK_projects] PRIMARY KEY NONCLUSTERED ([ID] ASC)
);
GO


CREATE UNIQUE CLUSTERED INDEX [UQ_projects_ID_createdby] ON [dbo].[projects] 
 (
  [ID] ASC, 
  [created_by] ASC
 )

GO







-- ************************************** [dbo].[common_files]

CREATE TABLE [dbo].[common_files]
(
 [ID]               int IDENTITY (1, 1) NOT NULL ,
 [file_name]        varchar(50) NOT NULL ,
 [custom_file_name] varchar(50) NOT NULL ,
 [uploaded_by]      int NOT NULL ,

 CONSTRAINT [PK_common_files] PRIMARY KEY NONCLUSTERED ([ID] ASC)
);
GO


CREATE UNIQUE CLUSTERED INDEX [UQ_common_files_id_uploadedby] ON [dbo].[common_files] 
 (
  [ID] ASC, 
  [uploaded_by] ASC
 )

GO







-- ************************************** [dbo].[common_file_types]

CREATE TABLE [dbo].[common_file_types]
(
 [ID]              int IDENTITY (1, 1) NOT NULL ,
 [file_type]       varchar(50) NOT NULL ,
 [effective_start] datetime NOT NULL ,
 [effective_end]   datetime NOT NULL ,

 CONSTRAINT [PK_common_file_types] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO








-- ************************************** [dbo].[project_files]

CREATE TABLE [dbo].[project_files]
(
 [ID]              int IDENTITY (1, 1) NOT NULL ,
 [project_id]      int NOT NULL ,
 [file_id]         int NOT NULL ,
 [file_type]       int NOT NULL ,
 [display_order]   int NOT NULL ,
 [effective_start] datetime NOT NULL ,
 [effective_end]   datetime NULL ,

 CONSTRAINT [PK_project_files] PRIMARY KEY NONCLUSTERED ([ID] ASC),
 CONSTRAINT [FK_project_files_common_file_types] FOREIGN KEY ([file_type])  REFERENCES [dbo].[common_file_types]([ID]),
 CONSTRAINT [FK_project_files_common_files] FOREIGN KEY ([file_id])  REFERENCES [dbo].[common_files]([ID]),
 CONSTRAINT [FK_project_files_projects] FOREIGN KEY ([project_id])  REFERENCES [dbo].[projects]([ID])
);
GO


CREATE UNIQUE CLUSTERED INDEX [UQ_project_files_projectid_fileid_filetype] ON [dbo].[project_files] 
 (
  [project_id] ASC, 
  [file_id] ASC, 
  [file_type] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fk_project_files_common_file_types] ON [dbo].[project_files] 
 (
  [file_type] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fk_project_files_common_files_files_id] ON [dbo].[project_files] 
 (
  [file_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fk_projects_projectfiles_project_id] ON [dbo].[project_files] 
 (
  [project_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [IDX_project_files_projectid] ON [dbo].[project_files] 
 (
  [project_id] ASC, 
  [file_id] ASC, 
  [ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [IDX_project_files_projectid_filetype] ON [dbo].[project_files] 
 (
  [file_type] ASC, 
  [ID] ASC, 
  [project_id] ASC
 )

GO







